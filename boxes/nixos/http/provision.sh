#! /bin/bash

# Partition
parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MB -8GB
parted /dev/sda -- set 1 boot on
parted /dev/sda -- mkpart primary linux-swap -8GB 100%

# Formating
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2

# Installation
mount /dev/disk/by-label/nixos /mnt
nixos-generate-config --root /mnt
curl $REMOTE_HTTP/configuration.nix -o /mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd && reboot