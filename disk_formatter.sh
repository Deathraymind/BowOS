#!/bin/bash                                                                                              
# Redirect all output to a log file
exec > >(tee -i /mnt/disk_formatter.log)
exec 2>&1

# Call the Python Textual UI to format the disk

# After the disk is formatted, continue with the NixOS installation
nixos-generate-config --root /mnt
nixos-install --no-root-passwd
nixos-enter -- nix-shell -p git --run '
git clone --branch beta https://github.com/deathraymind/BowOS

cd BowOS
rm -r .git 
rm flake.lock
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
export NIXPKGS_ALLOW_INSECURE=1
export NIX_USER=
nixos-rebuild boot --install-bootloader --impure --flake .
'

