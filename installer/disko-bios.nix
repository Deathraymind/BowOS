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
        device = "/dev/${disk}"; # Ensure `${disk}` is correctly set
        content = {
          type = "gpt"; # Keep GPT (MBR is NOT supported by disko)
          partitions = {
            bios_boot = {
              size = "1M";
              type = "EF02"; # Required for GRUB BIOS boot on GPT
            };
            root = {
              size = "-${swapSize}G"; # Fill remaining space except for swap
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

  # Explicitly define the root filesystem in fileSystems
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos"; # Make sure this label matches what you format the root partition with
    fsType = "ext4";
  };
}

