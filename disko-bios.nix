let
  disk = builtins.getEnv "BOWOS_DISK"; # Without /dev/
  swapSize = builtins.getEnv "BOWOS_SWAPSIZE"; # Just the size in gigs like 4 is = 4G
  # Usage:
  # BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko-bios.nix
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/${disk}";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # BIOS boot partition for GRUB with GPT
              # No content field for BIOS boot partition
            };
            boot_mount = {
              size = "512M";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "${swapSize}G";
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}

