#
#  Games nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ games.nix *
#

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher-qt5
    temurin-jre-bin-17
    lutris
    mangohud
    wineWowPackages.wayland
  ];

  programs = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
  };
}
