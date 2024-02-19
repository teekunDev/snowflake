#
#  Common nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix *
#               ├─ hardware-configuration.nix +
#               └─ ./modules
#                   ├─ audio.nix +
#                   ├─ code.nix +
#                   ├─ docker.nix +
#                   ├─ games.nix +
#                   ├─ hyprland.nix +
#                   ├─ openrgb.nix +
#                   ├─ ssh.nix +
#                   ├─ symlink.nix +
#                   ├─ thunar.nix +
#                   └─ xremap.nix +
#

{ config, lib, pkgs, inputs, vars, host, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/audio.nix
    ./modules/code.nix
    ./modules/docker.nix
    ./modules/games.nix
    ./modules/hyprland.nix
    ./modules/openrgb.nix
    ./modules/ssh.nix
    ./modules/symlink.nix
    ./modules/thunar.nix
  ];

  programs.zsh.enable = true;
  users.users.${vars.user} = {
    isNormalUser = true;
    password = "123";
    extraGroups = [ "wheel" "networkmanager" "corectrl" "wireshark" ];
    shell = pkgs.zsh;
  };

  # for xremap
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "${vars.user}" ];
  users.groups.input.members = [ "${vars.user}" ];

  networking = {
    hostName = "${host.hostName}";
    enableIPv6 = false;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networkmanager.enable = true;
    networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    extraHosts = ''
      192.168.2.1 speedport.ip
      192.168.2.2 asus.router
      192.168.2.111 n.k.d
    '';
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  hardware.i2c.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  fonts = {
    packages = with pkgs; [
      nerdfonts
    ];
    fontconfig.defaultFonts = {
      serif = [ "Source Code Pro" ];
      sansSerif = [ "Source Code Pro" ];
      monospace = [ "Source Code Pro" ];
      emoji = [ "Hack Nerd Font" ];
    };
  };

  environment = {
    variables = {
      NIXOS_ALLOW_UNFREE = "1";
      NIXOS_SECRETS = "${vars.secrets}";
      NIXOS_FILES = "${vars.location}/files";
      NIXOS_WALLDIR = "${vars.walldir}";
      PATH = [
        "${vars.location}/files/scripts"
      ];
      TERMINAL = "kitty";
      EDITOR = "code";
      VISUAL = "code";
    };
    systemPackages = with pkgs; [
      zip
      unzip
      p7zip
      unrar
      eza
      libnotify
      ntfy
      btop nvtop
      feh
      mpv
      vlc
      gimp
      gnome.file-roller
      okular
      libsForQt5.polkit-kde-agent
      networkmanagerapplet
      mako
      appimage-run
      eww-wayland
      qbittorrent-qt5
      libreoffice-qt
      imagemagick
      ffmpeg
      cifs-utils
      alsa-utils
      jq
      killall
      nano
      pciutils
      inotify-tools
      curl
      wget
      parsec-bin
      ungoogled-chromium
      file
      yt-dlp
      man-pages
      man-pages-posix
      moonlight-qt
      virt-manager
      xivlauncher
      xclip
      notepadqq
    ];
  };

  documentation.dev.enable = true;

  programs.corectrl.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  services.ddccontrol.enable = true;
  services.fstrim.enable = true;
  services.blueman.enable = true;
  services.syncthing = {
    enable = true;
    user = "${vars.user}";
    dataDir = "/stuff/syncthing";
    configDir = "/stuff/syncthing/.sc";
  };

  services = {
    xserver.layout = "de";
    flatpak.enable = true;
    printing.enable = true;
    printing.drivers = with pkgs; [ hplip ];
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
  };

  nix = {
    settings = {
      trusted-users = [ "${vars.user}" "@wheel" ];
      auto-optimise-store = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    ''; 
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
