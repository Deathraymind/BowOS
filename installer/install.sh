#!/bin/bash
# Purpose: This is a terminal script installer for BowOS, an alternative to the Rust GUI installer.
echo "System drives:"
lsblk
echo "What drive do you want to install on? (Enter the name only, e.g., for /dev/sda, just type sda)"
read BOWOS_DRIVE

echo "Is this system EFI or BIOS? (Type 'efi' or 'bios')"
read BOOT_TYPE

if [[ "$BOOT_TYPE" == "efi" ]]; then
    BOOT_DRIVE="nodev"
else
    BOOT_DRIVE="$BOWOS_DRIVE"
fi

echo "What do you want the username to be?"
read BOWOS_USER

echo "What do you want the password to be?"
read BOWOS_PASSWORD



echo "What swap size do you want? (Recommended: equal to your RAM in GB. Default is 4GB)"
read -p "Enter swap size (in GB, e.g., 4): " BOWOS_SWAPSIZE
BOWOS_SWAPSIZE=${BOWOS_SWAPSIZE:-4} # Default to 4 if input is empty

# Start installation process
git clone https://github.com/deathraymind/bowos 
cd bowos/installer || exit

if [[ "$BOOT_TYPE" == "bios" ]]; then
    BOWOS_SWAPSIZE="$BOWOS_SWAPSIZE" BOWOS_USER="$BOWOS_USER" BOWOS_DISK="$BOWOS_DRIVE" \
    sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
        github:nix-community/disko -- --mode disko disko-bios.nix --arg device "/dev/$BOWOS_DRIVE"
elif [[ "$BOOT_TYPE" == "efi" ]]; then
    BOWOS_SWAPSIZE="$BOWOS_SWAPSIZE" BOWOS_USER="$BOWOS_USER" BOWOS_DISK="$BOWOS_DRIVE" \
    sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
        github:nix-community/disko -- --mode disko disko-uefi.nix --arg device "/dev/$BOWOS_DRIVE"
else
    echo "Invalid boot type. Exiting."
    exit 1
fi

nixos-generate-config --root /mnt

# Copy preferences directory
cp -r preferences /etc/nixos

# Update grub configuration based on boot type
if [ "$BOOT_DRIVE" == "nodev" ]; then
    # For initial install
    # sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/configuration.nix
    # sed -i '/boot.loader.grub.efiSupport/d' /mnt/etc/nixos/configuration.nix

     sed -i '5i boot.loader.grub.device = "nodev";' /etc/nixos/preferences/configuration-preferences.nix
     sed -i '6i boot.loader.grub.efiSupport = true;' /etc/nixos/preferences/configuration-preferences.nix
     cp -r /etc/nixos/preferences /mnt/etc/nixos/

    # For constant preference

else
    # For initial install
    sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/configuration.nix
    sed -i "20i boot.loader.grub.device = \"/dev/$BOOT_DRIVE\";" /mnt/etc/nixos/configuration.nix
    sed -i '/boot.loader.grub.efiSupport/d' /mnt/etc/nixos/configuration.nix


    # For constant preference
    sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i "5i boot.loader.grub.device = \"/dev/$BOOT_DRIVE\";" /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i '/boot.loader.grub.efiSupport/d' /mnt/etc/nixos/configuration.nix

fi

# Install NixOS
BOWOS_USER="$BOWOS_USER" sudo -E nixos-install --flake .#amd --no-root-passwd --impure


BOWOS_USER="$BOWOS_USER" BOWOS_PASSWORD="$BOWOS_PASSWORD" nixos-enter -- nix-shell -p expect --extra-experimental-features flakes --run '
  # Set the username and password

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
  '

