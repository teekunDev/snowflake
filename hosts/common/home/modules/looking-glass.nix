#
#  Looking-Glass home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ looking-glass.nix *
#

{
  programs.looking-glass-client = {
    enable = true;
  };
}