#
#  server hardware configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix
#       └─ ./server
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ hardware-configuration.nix *
#

{ config, lib, pkgs, host, ... }:

{
  boot = {
    initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
    kernelModules = [ "kvm-amd" ];

    swraid.enable = false; # https://github.com/NixOS/nixpkgs/issues/254807
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      
      grub = {
        enable = true;
        device = "/dev/disk/by-label/GRUB";
      };

      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/ROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  fileSystems."/stuff" =
    {
      device = "/dev/disk/by-label/STUFF";
      fsType = "ext4";
    };

  services.qemuGuest.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    useDHCP = false;
    hostName = "${host.hostName}";
    enableIPv6 = false;
    interfaces = {
      enp6s18.ipv4.addresses = [{
        address = "192.168.1.11";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}