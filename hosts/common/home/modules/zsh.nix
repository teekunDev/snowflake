#
#  zsh home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ zsh.nix *
#

{ pkgs, location, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa --icons";
      rebuild = "sudo nixos-rebuild switch --flake ${location}# --impure && reload.sh";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "1386f1213eb0b0589d73cd3cf7c56e6a972a9bfd";
          sha256 = "iKx7lsQCoSAbpANYFkNVCZlTFdwOEI34rx/h1rnraSg=";
        };
      }
    ];
  };
}
