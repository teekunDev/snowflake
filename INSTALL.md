# Installing

- `nix-shell -p git`
- `git clone git@github.com:keifufu/nixos-config.git`

## Create Partitions

### EFI

- `sudo fdisk /dev/nvme0n1`
- `g (gpt disk label)`
- `n`
- `1`
- `2048`
- `+500M`
- `t`
- `1 (EFI System)`

### Swap

- `n`
- `2`
- `default`
- `t`
- `19 (Linux swap)`

### root

- `n`
- `3`
- `default (fill up partition)`
- `default (fill up partition)`
- `w (write)`

## Label Partitions

- `sudo mkfs.fat -F 32 /dev/nvme0n1p1`
- `sudo fatlabel /dev/nvme0n1p1 BOOT`
- `sudo mkfs.ext4 /dev/nvme0n1p3 -L ROOT`

## Mount Partitions

- `sudo mount /dev/disk/by-label/ROOT /mnt`
- `sudo mkdir -p /mnt/boot`
- `sudo mount /dev/disk/by-label/BOOT /mnt/boot`

## Install NixOS

`sudo nixos-install --flake .#<host>`
