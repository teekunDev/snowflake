#
#  vscode home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ vscod.nix *
#

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
  };
}