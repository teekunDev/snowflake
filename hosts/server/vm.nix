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

{ pkgs, lib, host, vars, ... }:

{
  # TODO: write cpu-split-up whatever files
  # TODO: steal gpu from host when vm starts, give it back when it stops

  # TODO: only for laptop and server, desktop won't need a vm

  # TODO: network default needs to autostart too

  users.users.${vars.user}.extraGroups = [ "libvirtd" ];
  programs.dconf.enable = true;
  boot = {
    kernelModules = [
      "kvm-amd"
      "vfio"
      "vfio_pci"
      "vfio_virqfd"
      "vfio_iommu_type1"
    ];
    kernelParams = [
      "amd_iommu=on"
      "vfio-pci.ids=10de:2484,10de:228b"
    ];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}