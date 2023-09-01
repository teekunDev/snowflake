#
#  neofetch home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ neofetch.nix *
#


{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
  ];

  home.file.".config/neofetch/config.conf".source = ../../../../files/config/neofetch.conf;
}