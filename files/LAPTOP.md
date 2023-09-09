# Installing

## Wifi

- `sudo systemctl start wpa_supplicant`
- `wpa_cli`
- `scan`
- `scan_results`
- `add_network`
- `set_network 0 ssid "<SSID>"`
- `set_network 0 psk "<PASS>"`
- `enable_network 0`

## Cloning repo

- `nix-shell -p git`
- `git clone https://github.com/keifufu/nixos-config`

## Partitions

Only got one disk on my laptop, nvme0n1

- 1 - 500MB EFI
- 2 - 15GB SWAP
- 3 - 100GB ROOT
- 4 - 100GB STUFF
- 5 - 784.5GB GAMES

## Mount Partitions

- `sudo mount /dev/disk/by-label/ROOT /mnt`
- `sudo mkdir -p /mnt/boot`
- `sudo mount /dev/disk/by-label/BOOT /mnt/boot`

## Install NixOS

`sudo nixos-install --flake .#<host>`

## After install

- login as root
- `passwd <user>`
- login as \<user>
- `git clone https://github.com/keifufu/nixos-config ~/.nixos-config`
