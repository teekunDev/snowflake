#
#  Desktop specific home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./desktop
#           └─ home.nix *
#

# https://github.com/NixOS/nixos-search/issues/636#issuecomment-1477885841

let
  newestPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
  }) { config = { allowUnfree = true; }; };

  overlay = final: prev: {
    osu-lazer-bin = newestPkgs.osu-lazer-bin;
  };

  pkgs = import <nixpkgs> {
    overlays = [ overlay ];
    config = { allowUnfree = true; };
  };
in
{
  home.packages = with pkgs; [
    osu-lazer-bin
  ];
}
