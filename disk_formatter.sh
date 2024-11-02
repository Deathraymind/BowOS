#!/bin/bash

# Redirect all output to a log file
exec > >(tee -i /mnt/disk_formatter.log)
exec 2>&1

# Call the Python Textual UI to format the disk (Add the actual command here)
# python3 format_disk.py

# After the disk is formatted, continue with the NixOS installation
nixos-generate-config --root /mnt
nixos-install --no-root-passwd

cp -r /etc/BowOS /mnt

# Enter NixOS environment and run further setup
nixos-enter -- nix-shell -p git -p expect --run '

  cd BowOS
  rm -r .git 
  rm flake.lock
  export NIXPKGS_ALLOW_INSECURE=1
  export NIX_USER=bowyn
  export NIX_PASSWORD=6255

  # Create the user
  useradd -m "$NIX_USER"

  # Set the password for the new user and root using expect
  expect -c "
    spawn passwd $NIX_USER
    expect \"New password:\"
    send \"$NIX_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$NIX_PASSWORD\r\"
    expect eof
  "

  expect -c "
    spawn passwd root
    expect \"New password:\"
    send \"$NIX_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$NIX_PASSWORD\r\"
    expect eof
  "

  # Rebuild the system with the new configurations
  nixos-rebuild boot --install-bootloader --impure --flake .
'

