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

{ vars, ... }:

{
  users.users.${vars.user}.extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;
  };
}
