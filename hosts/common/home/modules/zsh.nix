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

{ pkgs, vars, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
if [[ -n "$IN_NIX_SHELL" ]]; then
  VIRTUAL_ENV=nix-shell
  VIRTUAL_ENV_DISABLE_PROMPT=0
fi
export PRISMA_QUERY_ENGINE_LIBRARY=/run/current-system/sw/lib/libquery_engine.node
export PRISMA_QUERY_ENGINE_BINARY=/run/current-system/sw/bin/query-engine
export PRISMA_MIGRATION_ENGINE_BINARY=/run/current-system/sw/bin/migration-engine
export PRISMA_FMT_BINARY=/run/current-system/sw/bin/prisma-fmt

    '';
    shellAliases = {
      ls = "eza --icons -a --group-directories-first";
      rebuild = "sudo nixos-rebuild switch --flake ${vars.location}# --impure";
      rebuild-upgrade = "nix flake update ${vars.location} && sudo nixos-rebuild switch --flake ${vars.location}# --impure";
      lazypush = "lazypush.sh";
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
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.7.0";
          sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
        };
      }
    ];
  };
}
