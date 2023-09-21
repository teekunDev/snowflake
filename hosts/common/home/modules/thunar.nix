#
#  thunar home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ thunar.nix *
#

{ vars, ... }:

{
  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///stuff
    file:///stuff/code
    file:///smb
    file:///smb/pictures
    file:///smb/other
    file:///home/${vars.user}/Downloads
  '';
}