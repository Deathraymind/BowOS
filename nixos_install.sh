#!/bin/bash

# Ensure we're running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Disk setup
DISK="/dev/sda"
BOOT_PART="${DISK}1"
ROOT_PART="${DISK}2"

echo "Formatting ${DISK} for NixOS installation..."

# Step 1: Partition the disk
# UEFI partition layout with boot and root partitions
parted --script "${DISK}" -- mklabel gpt
parted --script "${DISK}" -- mkpart ESP fat32 1MiB 512MiB
parted --script "${DISK}" -- set 1 boot on
parted --script "${DISK}" -- mkpart primary ext4 512MiB 100%

# Step 2: Format the partitions
mkfs.fat -F 32 -n BOOT "${BOOT_PART}"
mkfs.ext4 -L NIXOS "${ROOT_PART}"

# Step 3: Mount the filesystems
mount "${ROOT_PART}" /mnt
mkdir -p /mnt/boot
mount "${BOOT_PART}" /mnt/boot

# Step 4: Run the NixOS installation
