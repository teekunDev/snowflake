#
#  Common hardware configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ hardware-configuration.nix *
#

{ config, lib, pkgs, secrets, ... }:


let
  getSambaHost = path: fallback:
    if lib.pathExists path then
      builtins.readFile path
    else
      fallback;
  smb-host = getSambaHost "${secrets}/smb_host" "192.168.2.111";
in
{
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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

  fileSystems."/smb" =
    {
      device = "//${smb-host}/data";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [ "${automount_opts},credentials=${secrets}/smb,uid=1000,gid=100" ];
    };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}