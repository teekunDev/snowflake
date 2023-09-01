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
  system.userActivationScripts.vscodelink = ''
    if [[ ! -h "$HOME/.config/Code" ]]; then
      ln -s "${symlink}/Code" "$HOME/.config/Code"
    fi
    if [[ ! -h "$HOME/.vscode" ]]; then
      ln -s "${symlink}/.vscode" "$HOME/.vscode"
    fi
  '';
}