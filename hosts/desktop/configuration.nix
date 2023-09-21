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

{
  imports = [
    ./hardware-configuration.nix
  ];
}
