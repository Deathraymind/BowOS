#!/bin/bash

# Ensure we are running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Set the disk variable
DISK="/dev/sda"  # Adjust as needed

echo "Unmounting ${DISK} and its partitions..."
umount -l "${DISK}" 2>/dev/null
umount -l "${DISK}1" 2>/dev/null
umount -l "${DISK}2" 2>/dev/null
umount -l "${DISK}3" 2>/dev/null

echo "Creating partitions..."
parted --script "${DISK}" -- mklabel gpt
parted --script "${DISK}" -- mkpart root ext4 512MiB -8GiB
parted --script "${DISK}" -- mkpart swap linux-swap -8GiB 100%
parted --script "${DISK}" -- mkpart ESP fat32 1MiB 512MiB
parted --script "${DISK}" -- set 3 esp on

echo "Formatting partitions..."
mkfs.ext4 -F -L nixos "${DISK}1"
mkswap -L swap "${DISK}2"
mkfs.fat -F 32 -n boot "${DISK}3"

echo "Mounting filesystems by label..."
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=007 /dev/disk/by-label/boot /mnt/boot

echo "Disk formatting and mounting complete!"

