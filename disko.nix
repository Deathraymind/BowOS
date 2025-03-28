let
    disk = builtins.getEnv "BOWOS_DISK"; # Without /dev/
    swapSize = builtins.getEnv "BOWOS_SWAPSIZE"; # Just the size in gigs like 4 is = 4G
    # run this command 
    # BOWOS_SWAPSIZE=4 sudo -E nix run github:nix-community/disko -- --mode disko disko.nix --arg device /dev/vda
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/${disk}";# More portable
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
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
                format = "ext4";  # Changed from tmpfs to ext4
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
