#
#  Thunar nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ thunar.nix *
#

{ pkgs, ... }:

{
  services.tumbler.enable = true; # image thumbnails
  services.gvfs.enable = true; # mount, trash, other functionalities
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer # video thumbnails
    webp-pixbuf-loader # webp thumbnails
  ];
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
  };
}
