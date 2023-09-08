#
#  OpenRGB nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ openrgb.nix *
#

{ pkgs, lib, ... }:

{
  config = {
    services.hardware.openrgb.enable = true;
    services.hardware.openrgb.motherboard = "amd";
  };
}