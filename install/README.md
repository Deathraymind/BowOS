This is the instructions for the bowos installer, there will be a gui rust installer, but these will be the commands ran in this orders


git clone https://github.com/deathraymind/bowos 
cd bowos/installer 

if BIOS 
BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko-bios.nix --arg device /dev/vda

if UEFI 
BOWOS_SWAPSIZE=4 BOWOS_USER=bowyn BOWOS_DISK=vda sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:nix-community/disko -- --mode disko disko-uefi.nix --arg device /dev/vda

then
nixos-generate-config --root /mnt
BOWOS_DISK=vda sudo -E bash bios-disk.sh 

nixos-generate-config --root /mnt --no-root-passwd
cd ..
BOWOS_USER=bowyn sudo -E nixos-install --flake .#amd --no-root-passwd --impure 





