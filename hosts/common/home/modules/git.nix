#
#  Git home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ git.nix *
#

{ secrets, ... }:

{
  programs.git = {
    enable = true;
    userName = "keifufu";
    userEmail = "github@keifufu.dev";
    signing = {
      # imported by exec-once in hyprland, scuffed but it'll do for now :v
      key = "861CB7ABE74F8EAD";
      signByDefault = true;
    };
    extraConfig = {
      core.sshcommand = "ssh -i ${secrets}/git-ssh-key";
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}