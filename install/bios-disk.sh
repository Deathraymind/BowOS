cp -r preferences /mnt/etc/nixos/
# for inital install 
sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/configuration.nix
sed -i "20i boot.loader.grub.device = \"/dev/$BOWOS_DISK\"" /mnt/etc/nixos/configuration.nix
# for constant preference
sed -i '/boot.loader.grub.device/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
sed -i "20i boot.loader.grub.device = \"/dev/$BOWOS_DISK\"" /mnt/etc/nixos/preferences/configuration-preferences.nix

