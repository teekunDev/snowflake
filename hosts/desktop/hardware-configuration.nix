#
#  Desktop specific hardware configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./desktop
#           └─ hardware-configuration.nix *
#

{ config, lib, pkgs, modulesPath, user, host, secrets, ... }:

{
  imports =
    [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
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

  fileSystems."/osu" =
    {
      device = "/dev/disk/by-label/OSU";
      fsType = "ntfs-3g";
    };

  # Note: having this enabled made steam not launch :nyaboom:
  /* fileSystems."/data" =
    {
      device = "//192.168.2.111/data";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [ "${automount_opts},credentials=${secrets}/smb,uid=33,gid=33" ];
    }; */

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance"; # laptop should be "powersave"
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    useDHCP = false;
    hostName = "${host.hostName}";
    enableIPv6 = false;
    interfaces = {
      enp4s0.ipv4.addresses = [{
        address = "192.168.2.112";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.2.1";
    nameservers = [ "192.168.2.111" "1.1.1.1" ];
  };
}
