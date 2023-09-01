#
#  mako home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ mako.nix *
#

{
  services.mako = {
    enable = true;
  };
}