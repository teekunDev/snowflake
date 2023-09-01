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
    osu-lazer-bin
  ];

  programs = {
    steam.enable = true;
  };
}
