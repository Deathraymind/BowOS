let
  disk = builtins.getEnv "BOWOS_DISK"; # Without /dev/
  swapSize = builtins.getEnv "BOWOS_SWAPSIZE"; # Just the size in gigs like 4 is = 4G
  isUEFI = builtins.getEnv "BOWOS_UEFI" == "1"; # Set BOWOS_UEFI=1 for UEFI systems
  # run this command for UEFI:
  # BOWOS_UEFI=1 BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko.nix --arg device /dev/vda
  # or for BIOS:
  # BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko.nix --arg device /dev/vda
  # Then:
  # nixos-generate-config --root /mnt
  # nixos-install
  # BOWOS_USER=bowyn sudo -E nixos-install --flake .#amd --no-root-passwd --impure 
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/${disk}";
        content = if isUEFI then {
          # UEFI Configuration (GPT)
          type = "gpt";
          partitions = {
            # BIOS boot partition (for hybrid compatibility)
            biosboot = {
              size = "1M";
              type = "EF02"; # BIOS boot partition type
              content = {
                type = "null";
              };
            };
            # ESP (EFI System Partition)
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            # Swap partition
            swap = {
              size = "${swapSize}G";
              content = {
                type = "swap";
              };
            };
            # Root partition
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        } else {
          # BIOS/Legacy Configuration (MBR)
          type = "msdos";
          partitions = {
            # Boot partition
            boot = {
              size = "512M";
              type = "primary";
              flags = ["boot"];
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            # Swap partition
            swap = {
              size = "${swapSize}G";
              type = "primary";
              content = {
                type = "swap";
              };
            };
            # Root partition
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
