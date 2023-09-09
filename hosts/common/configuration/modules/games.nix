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
    prismlauncher
    temurin-jre-bin-17
  ];

  programs = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
  };
}
