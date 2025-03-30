let
  disk = builtins.getEnv "BOWOS_DISK"; # Without /dev/
  swapSize = builtins.getEnv "BOWOS_SWAPSIZE"; # Just the size in gigs like 4 is = 4G
 # run this command 
    # BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko-bios.nix --arg device /dev/vda
    # nixos-generate-config --root /mnt
    # nixos-install
    # BOWOS_USER=bowyn sudo -E nixos-install --flake .#amd --no-root-passwd --impure 

in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/${disk}"; # Ensure `${disk}` is properly set
        content = {
          type = "mbr"; # Use MBR for legacy boot
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # BIOS boot partition for GRUB with GPT (safe to keep for consistency)
            };
            root = {
              size = "-${swapSize}G"; # Uses remaining space minus swap
              bootable = true; # Required for Legacy Boot
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            swap = {
              size = "${swapSize}G";
              content = {
                type = "swap";
              };
            };
          };
        };
      };
    };
  };
}

