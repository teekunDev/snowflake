#
#  Laptop specific nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./laptop
#           ├─ configuration.nix *
#           └─ hardware-configuration.nix +
#

{ pkgs, lib, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
}
