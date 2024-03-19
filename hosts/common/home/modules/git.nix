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

{ vars, ... }:

{
  programs.git = {
    enable = true;
    userName = "teekunDev";
    userEmail = "teekun@teekun.dev";
    signing = {
      # imported by exec-once in hyprland, scuffed but it'll do for now :v
       key = "2A3AD143587974A4";
       signByDefault = true;
    };
    extraConfig = {
      core.sshcommand = "ssh -i ${vars.secrets}/git-ssh-key";
      init.defaultBranch = "main";
      pull.rebase = false;
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}