#! /bin/sh

# Partition
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -8GB
parted /dev/sda -- mkpart swap linux-swap -8GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

# Formating
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

# Installation
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt
curl $REMOTE_HTTP/configuration.nix -o /mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd && reboot