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

{ pkgs, lib, user, host, ... }:

{
  users.users.${user}.extraGroups = [ "libvirtd" ];
  programs.dconf.enable = true;
  boot = {
    kernelModules = [
      "kvm-amd"
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"
    ];
    kernelParams = [
      "amd_iommu=on"
      ("vfio-pci.ids=" + lib.concatStringsSep "," host.gpuIDs)
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