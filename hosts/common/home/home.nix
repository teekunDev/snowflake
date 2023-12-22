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
      # Terminal
      btop              # Resource Manager
      nvtop             # Resource Manager (GPU)
      ranger            # File Manager
      tldr              # Manpage Helper
      eza               # Modern ls replacement
      ddcutil           # I2C CLI
      libnotify         # Notification cli
      ntfy              # Ntfy cli

      # Media
      feh               # Image Viewer
      mpv               # Media Player
      vlc               # Media Player
      gimp              # Image Editor

      # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      p7zip             # Zip Encryption
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip

      # Other
      libsForQt5.polkit-kde-agent # Polkit Agent
      networkmanagerapplet        # Networkmanager app
      mako                        # Notification Daemon
      appimage-run                # appimage

      xwaylandvideobridge
      eww-wayland
    ];

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
