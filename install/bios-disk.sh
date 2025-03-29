sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/configuration.nix
sed -i "20i boot.loader.grub.device = \"/dev/$BOWOS_DISK\"" /mnt/etc/nixos/configuration.nix

