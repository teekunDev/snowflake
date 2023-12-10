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
    clang-tools
    gf
    (pkgs.python3.withPackages(ps: with ps; [ aiohttp opencv4 ]))
  ];
}