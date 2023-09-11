#
#  VSCode home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ vscode.nix *
#

{ pkgs, ... }:

{
  # Note: settings are symlinked in hosts/common/configuration/modules/symlink.nix
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # streetsidesoftware.code-spell-checker
      serayuzgur.crates
      rust-lang.rust-analyzer
      formulahendry.auto-rename-tag
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      naumovs.color-highlight
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      tamasfe.even-better-toml
      github.vscode-github-actions
      eamodio.gitlens
      ms-vscode.live-server
      bbenoist.nix
      esbenp.prettier-vscode
      humao.rest-client
    ];
  };
}