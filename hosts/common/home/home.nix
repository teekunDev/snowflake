#
#  Common home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./common
#           └─ ./home
#               ├─ home.nix *
#               └─ ./modules
#                   ├─ bat.nix +
#                   ├─ btop.nix +
#                   ├─ firefox.nix +
#                   ├─ git.nix +
#                   ├─ gpg.nix +
#                   ├─ hyprland.nix +
#                   ├─ kitty.nix +
#                   ├─ mako.nix +
#                   ├─ neofetch.nix +
#                   ├─ obs-studio.nix +
#                   ├─ rnnoise.nix +
#                   ├─ swaylock.nix +
#                   ├─ theming.nix +
#                   ├─ thunar.nix +
#                   ├─ vscode.nix +
#                   ├─ waybar.nix +
#                   ├─ wlogout.nix +
#                   ├─ wofi.nix +
#                   └─ zsh.nix +
#

{ inputs, config, lib, pkgs, vars, ... }:

{
  imports = [
    ./modules/bat.nix
    ./modules/btop.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/hyprland.nix
    ./modules/kitty.nix
    ./modules/mako.nix
    ./modules/neofetch.nix
    ./modules/obs-studio.nix
    ./modules/rnnoise.nix
    ./modules/wofi.nix
    ./modules/swaylock.nix
    ./modules/theming.nix
    ./modules/thunar.nix
    ./modules/vscode.nix
    ./modules/waybar.nix
    ./modules/wlogout.nix
    ./modules/zsh.nix
  ];

  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";

    packages = with pkgs; [
      btop
      nvtop
      ranger
      tldr
      eza
      libnotify
      ntfy
      feh
      mpv
      vlc
      gimp
      gnome.file-roller
      okular
      p7zip
      unzip
      unrar
      zip
      libsForQt5.polkit-kde-agent
      networkmanagerapplet
      mako
      appimage-run
      xwaylandvideobridge
      eww-wayland
      qbittorrent-qt5
    ];

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
