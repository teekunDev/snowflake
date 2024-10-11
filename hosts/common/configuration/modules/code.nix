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
    yarn
    rustup
    gcc
    php
    php82Packages.composer
    glibc
    prisma-engines
    go
    

    (pkgs.python3.withPackages(ps: with ps; [ aiohttp opencv4 ]))

    (pkgs.php.buildEnv {
    extensions = ({ enabled, all }: enabled ++ (with all; [
      xdebug
      curl
      fileinfo
      openssl
      pdo_mysql
      sockets
      sodium
    ]));
    extraConfig = ''
      xdebug.mode=debug
    '';
  })

    clang-tools
    gf
    virtualenv
    (pkgs.python3.withPackages(ps: with ps; [ aiohttp opencv4 ]))
  ];


}