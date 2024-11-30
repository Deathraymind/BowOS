#!/bin/bash

# Redirect all output to a log file
exec > >(tee -i /mnt/disk_formatter.log)
exec 2>&1

# Call the Python Textual UI to format the disk (Add the actual command here)
# python3 format_disk.py

# After the disk is formatted, continue with the NixOS installation
nixos-generate-config --root /mnt
cp -f configuration.nix /mnt/etc/nixos
nixos-install --no-root-passwd

echo copying packages
echo this make take a minute

# add these lines 
# cp bowos-packages.nar /mnt 
# nixos-enter 
# nix-store --import < bowos-packages.nar
# Enter NixOS environment and run further setup
mkdir -p /mnt/tmp
nix-store -qR /run/current-system > installed-packages.txt
nix-store --export $(cat installed-packages.txt) > /mnt/tmp/bowos-packages.nar

cp -r /etc/BowOS /mnt
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
  nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  nix-channel --update

  echo unpacking packages

  nix-store --import < /tmp/bowos-packages.nar

  # Set NIX_CONFIG for flakes
  export NIX_CONFIG="experimental-features = nix-command flakes"
  
  # Rebuild NixOS
  nixos-rebuild boot --install-bootloader --impure --flake .
'

