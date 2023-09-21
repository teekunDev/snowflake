#
#  swaylock home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ swaylock.nix *
#

{ pkgs, vars, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "${vars.location}/files/wall.png";
      indicator = true;
      clock = true;
      datestr = "%a, %Y-%m-%d";
      indicator-idle-visible = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      inside-color = "1e1e2e";
      inside-clear-color = "1e1e2e";
      inside-caps-lock-color = "1e1e2e";
      inside-ver-color = "1e1e2e";
      inside-wrong-color = "1e1e2e";
      key-hl-color = "c6a0f6";
      layout-border-color = "313244";
      layout-text-color = "313244";
      line-color = "313244";
      line-clear-color = "313244";
      line-caps-lock-color = "313244";
      line-ver-color = "313244";
      line-wrong-color = "313244";
      ring-color = "313244";
      ring-clear-color = "313244";
      ring-caps-lock-color = "313244";
      ring-ver-color = "313244";
      ring-wrong-color = "313244";
      separator-color = "313244";
      text-color = "cdd6f4";
      text-clear-color = "cdd6f4";
      text-caps-lock-color = "cdd6f4";
      text-ver-color = "cdd6f4";
      text-wrong-color = "cdd6f4";
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
    };
  };
}