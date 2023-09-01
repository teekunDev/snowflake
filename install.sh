#!/usr/bin/env bash

sudo mount /dev/disk/by-label/ROOT /mnt
sudo mkdir /mnt/boot
sudo mount /dev/disk/by-label/BOOT /mnt/boot

sudo nixos-install --flake .#desktop