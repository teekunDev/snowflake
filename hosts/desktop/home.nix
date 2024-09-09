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

# let
#   osu = pkgs.callPackage ../../pkgs/osu-lazer/bin.nix { };
# in
# {
#   home.packages = [
#     osu
#   ];
# }
