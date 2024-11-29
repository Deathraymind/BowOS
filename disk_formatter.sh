#!/bin/bash

# Redirect all output to a log file
exec > >(tee -i /mnt/disk_formatter.log)
exec 2>&1

# Call the Python Textual UI to format the disk (Add the actual command here)
# python3 format_disk.py

# After the disk is formatted, continue with the NixOS installation
nixos-generate-config --root /mnt
nixos-install --no-root-passwd

echo copying packages
echo this make take a minute

# add these lines 
# cp bowos-packages.nar /mnt 
# nixos-enter 
# nix-store --import < bowos-packages.nar
# Enter NixOS environment and run further setup
nixos-enter -- nix-shell -p expect --run '

  # Set the password for the new user and root using expect
  
  export BOWOS_USER=bowyn
  export BOWOS_PASSWORD=6255
  # Create the user
  useradd -m "$BOWOS_USER"


  expect -c "
    spawn passwd $BOWOS_USER
    expect \"New password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect eof
  "

  expect -c "
    spawn passwd root
    expect \"New password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect eof
  "

  echo Unpacking .nar file, This will take a while



  
  
  # Rebuild the system with the new configurations
  cd BowOS
  rm -r .git 
  echo building configuration
  export NIXPKGS_ALLOW_INSECURE=1
  nixos-rebuild boot --install-bootloader --impure --flake .
'

