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


echo "What swap size do you want? (Recommended: equal to your RAM in GB. Default is 4GB)"
read -p "Enter swap size (in GB, e.g., 4): " BOWOS_SWAPSIZE
BOWOS_SWAPSIZE=${BOWOS_SWAPSIZE:-4} # Default to 4 if input is empty

# Start installation process
git clone https://github.com/deathraymind/bowos 
cd bowos/installer || exit

if [[ "$BOOT_TYPE" == "bios" ]]; then
    sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
        github:nix-community/disko -- --mode disko disko-bios.nix --arg device "/dev/$BOWOS_DRIVE"
elif [[ "$BOOT_TYPE" == "efi" ]]; then
    sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
        github:nix-community/disko -- --mode disko disko-uefi.nix --arg device "/dev/$BOWOS_DRIVE"
else
    echo "Invalid boot type. Exiting."
    exit 1
fi

nixos-generate-config --root /mnt

if [[ "$BOOT_TYPE" == "efi" ]]; then
    BOOT_DRIVE="nodev"
else
    BOOT_DRIVE="$BOWOS_DRIVE"
    sudo -E bash bios-disk.sh
fi


cd ..
sudo -E nixos-install --flake .#amd --no-root-passwd --impure

