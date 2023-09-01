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
#                   ├─ btop.nix +
#                   ├─ firefox.nix +
#                   ├─ git.nix +
#                   ├─ gpg.nix +
#                   ├─ hyprland.nix +
#                   ├─ kitty.nix +
#                   ├─ looking-glass.nix +
#                   ├─ mako.nix +
#                   ├─ neofetch.nix +
#                   ├─ obs-studio.nix +
#                   ├─ theming.nix +
#                   ├─ vm.nix +
#                   ├─ vscode.nix +
#                   ├─ waybar.nix +
#                   ├─ wofi.nix +
#                   └─ zsh.nix +
#

{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./modules/btop.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/hyprland.nix
    ./modules/kitty.nix
    ./modules/looking-glass.nix
    ./modules/mako.nix
    ./modules/neofetch.nix
    ./modules/obs-studio.nix
    ./modules/theming.nix
    ./modules/vm.nix
    ./modules/vscode.nix
    ./modules/waybar.nix
    ./modules/wofi.nix
    ./modules/zsh.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      nvtop             # Resource Manager (GPU)
      ranger            # File Manager
      tldr              # Manpage Helper
      exa               # Modern ls replacement
      ddcutil           # I2C CLI
      libnotify         # Notification cli

      # Media
      feh               # Image Viewer
      mpv               # Media Player
      vlc               # Media Player

      # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      p7zip             # Zip Encryption
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip

      # Social
      webcord-vencord
      # (discord.override {
      #   withVencord = true;
      # })

      # Other
      libsForQt5.polkit-kde-agent # Polkit Agent
      networkmanagerapplet        # Networkmanager app
      mako                        # Notification Daemon
    ];

    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
