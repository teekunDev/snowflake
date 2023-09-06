#
#  Code nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ code.nix *
#

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_18
    nodePackages.pnpm
    rustup
    gcc
    (pkgs.python3.withPackages(ps: with ps; [ aiohttp ]))
  ];
}