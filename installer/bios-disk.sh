#!/bin/bash

# Copy preferences directory
cp -r preferences /mnt/etc/nixos/

# Check if BOWOS_DISK is "nodev"
if [ "$BOOT_DRIVE" == "nodev" ]; then
    # For initial install
    sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/configuration.nix
    sed -i '20i boot.loader.grub.device = "nodev"' /mnt/etc/nixos/configuration.nix

    # For constant preference
    sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i '20i boot.loader.grub.device = "nodev"' /mnt/etc/nixos/preferences/configuration-preferences.nix
else
    # For initial install
    sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/configuration.nix
    sed -i "20i boot.loader.grub.device = \"/dev/$BOOT_DRIVE\"" /mnt/etc/nixos/configuration.nix

    # For constant preference
    sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i "5i boot.loader.grub.device = \"/dev/$BOOT_DRIVE\"" /mnt/etc/nixos/preferences/configuration-preferences.nix
fi

