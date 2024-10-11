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

{pkgs,inputs,...}:

{
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
  
  programs.firefox = {
    enable = true;
  };
}