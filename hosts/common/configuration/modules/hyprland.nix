#
#  Hyprland nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ hyprland.nix *
#

{ config, lib, pkgs, host, system, inputs, vars, ... }:

{
  environment = {
    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XKB_DEFAULT_LAYOUT = "de";
    };
    sessionVariables = {
      # nvidia stuff if needed
      # GBM_BACKEND = "nvidia-drm";
      # __GL_GSYNC_ALLOWED = "0";
      # __GL_VRR_ALLOWED = "0";
      # WLR_DRM_NO_ATOMIC = "1";
      # XDG_SESSION_TYPE = "wayland";
      # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # _JAVA_AWT_WM_NONREPARENTING = "1";
      # WLR_NO_HARDWARE_CURSORS = "1";
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";

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
      hyprpicker
      hyprpaper
      wlr-randr
      wf-recorder
      cliphist
    ];
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=yes
  '';

  # services.getty.autologinUser = "${vars.user}";
  # programs.zsh.loginShellInit = ''
  #   if [ -f "$HOME/.no-hypr" ]; then
  #     rm "$HOME/.no-hypr"
  #   else
  #     Hyprland
  #   fi
  # '';

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
