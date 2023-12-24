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
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      NIXOS_OZONE_WL = "1";

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
    };
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=yes
  '';

  services.getty.autologinUser = "${vars.user}";
  programs.zsh.loginShellInit = ''
    if [ -f "$HOME/.no-hypr" ]; then
      rm "$HOME/.no-hypr"
    else
      Hyprland
    fi
  '';

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
