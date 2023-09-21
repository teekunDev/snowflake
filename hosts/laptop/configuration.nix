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

{
  imports = [
    ./hardware-configuration.nix
  ];
}
