#
#  vm nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ vm.nix *
#

{ pkgs, lib, ... }:

let
  # RTX 3070
  gpuIDs = [
    "10de:2484" # Graphics
    "10de:228b" # Audio
  ];
in
{
  environment.systemPackages = with pkgs; [
    virt-manager
  ];
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"

    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.kernelParams = [
    "amd_iommu=on"
    ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
  ];
  # TODO: general vm config
  # TODO: sudo virsh net-autostart default
}