#
#  Audio nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ audio.nix *
#

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio  # just for pactl
    helvum # patchbay
  ];

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}