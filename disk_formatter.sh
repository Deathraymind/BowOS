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
export NIX_USER=bowyn
export NIX_PASSWORD=6255
nix-env -iA nixos.expect

spawn passwd useradd -m NIX_USER 
expect "New password:"
send "$NIX_PASSWORD\r"
expect "Retype new password:"
send "$NIX_PASSWORD\r"
expect eof

spawn passwd roots
expect "New password:"
send "$NIX_PASSWORD\r"
expect "Retype new password:"
send "$NIX_PASSWORD\r"
expect eof 

nixos-rebuild boot --install-bootloader --impure --flake .
'

