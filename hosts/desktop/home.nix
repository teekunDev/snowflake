#
#  Desktop specific home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./desktop
#           └─ home.nix *
#

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    osu-lazer-bin
  ];
}
