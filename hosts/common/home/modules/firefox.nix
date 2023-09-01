#
#  firefox home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ firefox.nix *
#

{
  programs.firefox = {
    enable = true;
  };
}