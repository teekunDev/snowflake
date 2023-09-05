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

{ user, ... }:

{
  users.users.${user}.extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;
  };
}
