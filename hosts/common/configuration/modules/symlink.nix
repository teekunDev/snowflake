#
#  symlink nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ symlink.nix *
#


{ symlink, ... }:

{
  # -h checks if it's a symbolic link, if it's not, we delete it and create a link
  system.userActivationScripts.vscodelink = ''
    if [[ ! -h "$HOME/.config/Code" ]]; then
      rm -rf $HOME/.config/Code
      ln -s "${symlink}/Code" "$HOME/.config/Code"
    fi
    if [[ ! -h "$HOME/.vscode" ]]; then
      rm -rf $HOME/.vscode
      ln -s "${symlink}/.vscode" "$HOME/.vscode"
    fi
    if [[ ! -h "$HOME/.mozilla" ]]; then
      rm -rf $HOME/.mozilla
      ln -s "${symlink}/.mozilla" "$HOME/.mozilla"
    fi
    if [[ ! -h "$HOME/.config/gtk-3.0/bookmarks" ]]; then
      rm -rf $HOME/.config/gtk-3.0/bookmarks
      ln -s "${symlink}/bookmarks" "$HOME/.config/gtk-3.0/bookmarks"
    fi
  '';
}