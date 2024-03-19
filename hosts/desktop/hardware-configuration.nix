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

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    useDHCP = false;
    enableIPv6 = false;
    interfaces = {
      enp42s0.ipv4.addresses = [{
        address = "192.168.1.4";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.1.1";
  };
}
