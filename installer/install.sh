#!/bin/bash
# Purpose: Terminal installer for BowOS – an alternative to the Rust GUI installer.

# Display available system drives.
echo "System drives:"
lsblk

# Ask for the target drive name (e.g. "sda" for /dev/sda)
echo "What drive do you want to install on? (Enter the name only, e.g., for /dev/sda, just type sda)"
read BOWOS_DRIVE

# Ask whether the system boots using EFI or BIOS.
if [ -d /sys/firmware/efi ]; then
    BOOT_TYPE="efi"
    echo "Detected boot type: UEFI"
else
    BOOT_TYPE="bios"
    echo "Detected boot type: BIOS"
fi
# Set BOOT_DRIVE variable based on boot type:
# If EFI, use "nodev" (since EFI doesn't use a specific boot device for GRUB in this setup)
# Otherwise (BIOS), use the drive specified.
if [[ "$BOOT_TYPE" == "efi" ]]; then
    BOOT_DRIVE="nodev"
else
    BOOT_DRIVE="$BOWOS_DRIVE"
fi

# Get the desired username and password for the new system.
echo "What do you want the username to be?"
read BOWOS_USER

echo "What do you want the password to be?"
read BOWOS_PASSWORD

# Ask for the swap size (in GB). Defaults to 4GB if the user enters nothing.
echo "What swap size do you want? (Recommended: equal to your RAM in GB. Default is 4GB)"
read -p "Enter swap size (in GB, e.g., 4): " BOWOS_SWAPSIZE
BOWOS_SWAPSIZE=${BOWOS_SWAPSIZE:-4} # Default to 4 if input is empty

# Clone the BowOS repository and move into the installer directory.

# Depending on the boot type (BIOS vs EFI), run the corresponding Disko command.
if [[ "$BOOT_TYPE" == "bios" ]]; then
    # For BIOS: Pass environment variables and run the disko command using the bios config.
    BOWOS_SWAPSIZE="$BOWOS_SWAPSIZE" BOWOS_USER="$BOWOS_USER" BOWOS_DISK="$BOWOS_DRIVE" \
    sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
        github:nix-community/disko -- --mode disko disko-bios.nix --arg device "/dev/$BOWOS_DRIVE"
elif [[ "$BOOT_TYPE" == "efi" ]]; then
    # For EFI: Pass the variables and run the disko command using the UEFI config.
    BOWOS_SWAPSIZE="$BOWOS_SWAPSIZE" BOWOS_USER="$BOWOS_USER" BOWOS_DISK="$BOWOS_DRIVE" \
    sudo -E nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
        github:nix-community/disko -- --mode disko disko-uefi.nix --arg device "/dev/$BOWOS_DRIVE"
else
    echo "Invalid boot type. Exiting."
    exit 1
fi

# Remove any existing /etc/nixos directory
rm -rf /etc/nixos

# Generate the NixOS configuration based on the detected hardware
nixos-generate-config --root /mnt

# Ensure the new /etc/nixos directory exists before copying
mkdir -p /etc/nixos

# Copy generated configuration from /mnt/etc/nixos to /etc/nixos
cp -r /mnt/etc/nixos/* /etc/nixos

# Copy only the contents of 'preferences' (not the folder itself) into both locations
cp -r preferences /mnt/etc/nixos


# Update the GRUB configuration based on the boot type.
if [ "$BOOT_DRIVE" == "nodev" ]; then
    :
    # For EFI systems, copy preferences into both /etc/nixos and /mnt/etc/nixos.
else
    # For BIOS systems, remove any existing GRUB device/efiSupport settings,
    # then insert the correct GRUB device configuration into the generated config.
    sed -i '/boot.loader.grub.devices/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i '/boot.loader.grub.efiSupport/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i '/boot.loader.efi.canTouchEfiVariables/d' /mnt/etc/nixos/preferences/configuration-preferences.nix
    sed -i '/boot.loader.grub.efiInstallAsRemovable/d' /mnt/etc/nixos/preferences/configuration-preferences.nix


    sed -i "5i boot.loader.grub.device = \"/dev/$BOOT_DRIVE\";" /mnt/etc/nixos/preferences/configuration-preferences.nix
fi



cp -r /mnt/etc/nixos/preferences /etc/nixos 

# Install NixOS using your flake configuration.
# --no-root-passwd indicates that no root password is being set during install.
BOWOS_USER="$BOWOS_USER" sudo -E nixos-install --flake .#install --no-root-passwd --impure

# Enter the new system to set the user and root passwords.
# This uses nixos-enter and an expect script (inside a nix-shell) to automate password setting.
BOWOS_USER="$BOWOS_USER" BOWOS_PASSWORD="$BOWOS_PASSWORD" nixos-enter -- nix-shell -p expect --extra-experimental-features flakes --run '
  # Create the new user account.
  useradd -m "$BOWOS_USER"

  # Use expect to set the password for the new user.
  expect -c "
    spawn passwd $BOWOS_USER
    expect \"New password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect eof
  "

  # Use expect to set the root password.
  expect -c "
    spawn passwd root
    expect \"New password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect \"Retype new password:\"
    send \"$BOWOS_PASSWORD\r\"
    expect eof
  "
'

