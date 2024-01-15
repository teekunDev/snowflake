#
#  Desktop specific hardware configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix
#       └─ ./desktop
#           ├─ configuration.nix !
#           └─ hardware-configuration.nix *
#

{ lib, modulesPath, host, ... }:

{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/osu" =
    {
      device = "/dev/disk/by-label/OSU";
      fsType = "ntfs-3g";
    };

  networking = {
    useDHCP = false;
    interfaces = {
      enp4s0.ipv4.addresses = [{
        address = "192.168.2.112";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.2.1";
  };
}
