#
#  gpg home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ gpg.nix *
#

{
  programs.gpg = {
    enable = true;
  };
}