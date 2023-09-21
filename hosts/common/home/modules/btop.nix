#
#  btop home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ btop.nix *
#

{
  # Seems themes have to be in .config/btop/themes and you can't just provide a path in color_theme.
  home.file.".config/btop/themes/catppuccin_mocha.theme".source = ../../../../files/themes/btop_catppuccin_mocha.theme;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha";
      theme_background = true;
    };
  };
}
