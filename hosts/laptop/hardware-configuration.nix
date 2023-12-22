#
#  Laptop specific hardware configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix
#       └─ ./laptop
#           ├─ configuration.nix !
#           └─ hardware-configuration.nix *
#

{ config, lib, modulesPath, ... }:

{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    nvidiaPersistenced = lib.mkForce true;
    modesetting.enable = lib.mkForce true;
    powerManagement.enable = lib.mkForce true;
    powerManagement.finegrained = lib.mkForce true;
    nvidiaSettings = lib.mkForce true;
    open = lib.mkForce false;
    prime = {
      offload.enableOffloadCmd = lib.mkForce true;
      offload.enable = lib.mkForce true;
      amdgpuBusId = lib.mkForce "PCI:5:0:0";
      nvidiaBusId = lib.mkForce "PCI:1:0:0";
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.tlp.enable = true;
}
