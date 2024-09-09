#
#  Games nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ games.nix *
#

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    temurin-jre-bin-17
    lutris
    mangohud
    wineWowPackages.wayland
    protontricks
    xemu          # XBOX Emulator

    (retroarch.override {
    cores = with libretro; [
      flycast
      snes9x
      fceumm
      desmume
    ];
  })

  ];

  programs = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
  };
}
