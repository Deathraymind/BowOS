#!/bin/bash

# Redirect all output to a log file
exec > >(tee -i /mnt/disk_formatter.log)
exec 2>&1

# Call the Python Textual UI to format the disk (Add the actual command here)
# python3 format_disk.py

# After the disk is formatted, continue with the NixOS installation
nixos-generate-config --root /mnt
# cp -f configuration.nix /mnt/etc/nixos
nixos-install --no-root-passwd

echo "Copying packages..."
echo "This may take a minute..."

# Export installed packages to a Nix archive
mkdir -p /mnt/tmp
nix-store -qR /run/current-system > installed-packages.txt
nix-store --export $(cat installed-packages.txt) > /mnt/tmp/bowos-packages.nar

# Copy BowOS configuration to the new system
cp -r /etc/BowOS /mnt

# Enter NixOS environment and run further setup
nixos-enter -- nix-shell -p expect --extra-experimental-features flakes --run '
  # Set the username and password
  export BOWOS_USER=bowyn
  export BOWOS_PASSWORD=6255

  # Create the user
  useradd -m "$BOWOS_USER"

  # Set the password for the new user using expect
  expect -c "
    spawn passwd $BOWOS_USER
    expect \"New password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect eof
  "

  # Set the password for root using expect
  expect -c "
    spawn passwd root
    expect \"New password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect eof
  "

  # Rebuild the system with the new configurations
  cd BowOS || exit 1
  rm -rf .git
  echo "Building configuration..."
  export NIXPKGS_ALLOW_INSECURE=1

  echo "Unpacking packages..."
  nix-store --import < /tmp/bowos-packages.nar

  # Set NIX_CONFIG for flakes
  sudo export NIX_CONFIG="experimental-features = nix-command flakes"
  
  # Rebuild NixOS
  BOWOS_USER=bowyn sudo -E nixos-rebuild boot --install-bootloader --impure --flake .#amd

  echo "BowOS is done flashing. You are free to reboot. The system will reboot shortly."
'

# Reboot the system after exiting the chroot environment
echo "Rebooting the system..."
for i in {10..1}; do
  echo "$i..."
  sleep 1  # 1-second delay
done
echo "I lied dummy reboot the system urself pfff"
