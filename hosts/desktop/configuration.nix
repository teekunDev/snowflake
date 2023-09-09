#
#  Desktop specific nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./desktop
#           ├─ configuration.nix *
#           └─ hardware-configuration.nix +
#

{ pkgs, lib, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    osu-lazer-bin
  ];
}
