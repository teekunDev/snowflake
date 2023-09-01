#
#  Docker nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ docker.nix *
#

{
  virtualisation.docker = {
    enable = true;
  };
}
