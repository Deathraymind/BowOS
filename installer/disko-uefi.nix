let
    disk = builtins.getEnv "BOWOS_DISK"; # Without /dev/
    swapSize = builtins.getEnv "BOWOS_SWAPSIZE"; # Just the size in gigs like 4 is = 4G
    # run this command 
    # BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko-uefi.nix --arg device /dev/vda
    # nixos-generate-config --root /mnt
    # nixos-install
    # BOWOS_USER=bowyn sudo -E nixos-install --flake .#amd --no-root-passwd --impure 
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/${disk}";  # Replace with your actual disk ID
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";  # EFI System Partition type
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "${swapSize}G";   # Adjust swap size as needed
              content = {
                type = "swap";
                # For hibernation, note that using randomEncryption is not compatible.
                # If you wish to encrypt swap without hibernation, you can uncomment the line below:
                # randomEncryption = true;
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

