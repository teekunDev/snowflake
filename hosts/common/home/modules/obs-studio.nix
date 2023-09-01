#
#  OBS-Studio home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ obs-studio.nix *
#

{
  programs.obs-studio = {
    enable = true;
  };
}