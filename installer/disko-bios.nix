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
        device = "/dev/${disk}"; # Make sure `${disk}` is properly set
        content = {
          type = "gpt"; # MBR is not supported by `disko`
          partitions = {
            bios_boot = {
              size = "1M";
              type = "EF02"; # Required for GRUB in legacy boot mode
            };
            root = {
              size = "100%";  # Use all remaining space
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            swap = {
              size = "${swapSize}G"; # Define swap size directly
              content = {
                type = "swap";
              };
            };
          };
        };
      };
    };
  };

  # Explicitly define the root filesystem in fileSystems
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos"; # Ensure this matches what you format the root partition with
    fsType = "ext4";
  };
}

