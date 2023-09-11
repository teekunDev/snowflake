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

{ symlink, location, ... }:

{
  # -h checks if it's a symbolic link, if it's not, we delete it and create a link
  system.userActivationScripts.vscodelink = ''
    if [[ ! -h "$HOME/.config/Code/User/settings.json" ]]; then
      mkdir -p $HOME/.config/Code/User
      rm -rf $HOME/.config/Code/User/settings.json
      ln -s "${location}/files/config/vscode.json" "$HOME/.config/Code/User/settings.json"
    fi
    if [[ ! -h "$HOME/.mozilla" ]]; then
      rm -rf $HOME/.mozilla
      ln -s "${symlink}/.mozilla" "$HOME/.mozilla"
    fi
  '';
}