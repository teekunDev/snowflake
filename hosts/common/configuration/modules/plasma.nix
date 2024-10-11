#
#  Plasma nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ plasma.nix *
#

{ config, lib, pkgs, host, system, inputs, vars, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;


  environment = {
    /* variables = {
      XDG_CURRENT_DESKTOP = "KDE";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "KDE";
      XKB_DEFAULT_LAYOUT = "de";
    };
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      NIXOS_OZONE_WL = "1";
      XCURSOR_SIZE = "24";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
    };
    systemPackages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
      wtype
      wlr-randr
      wf-recorder
    ]; */
    plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      plasma-browser-integration
      ark
      kate
      khelpcenter
      spectacle
      ffmpegthumbs
      krdp
    ];
  };
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=yes
  '';
}