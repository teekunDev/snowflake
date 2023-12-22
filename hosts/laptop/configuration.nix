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

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    lshw
    glxinfo
  ];
}
