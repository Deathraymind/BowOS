let
    disk = builtins.getEnv "BOWOS_DISK"; # Without /dev/
    swapSize = builtins.getEnv "BOWOS_SWAPSIZE"; # Just the size in gigs like 4 is = 4G
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/${disk}";
        content = {
          type = "msdos"; # Changed from gpt to msdos for BIOS
          partitions = {
            boot = {
              size = "1M";
              type = "primary";
              flags = ["boot"];
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "${swapSize}G";
              type = "primary";
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              type = "primary";
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
