#
#  Mullvad nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./configuration
#               ├─ configuration.nix !
#               └─ ./modules
#                   └─ mullvad.nix *
#

{ config, ... }:

{
  services.mullvad-vpn.enable = true;
  systemd.services.mullvad-daemon.postStart = let
    mullvad = config.services.mullvad-vpn.package;
  in ''
    while ! ${mullvad}/bin/mullvad status >/dev/null; do sleep 1; done
    ${mullvad}/bin/mullvad auto-connect set on
    ${mullvad}/bin/mullvad lan set allow
    ${mullvad}/bin/mullvad dns set custom 1.1.1.1 1.0.0.1
    ${mullvad}/bin/mullvad relay set location de fra
  '';
}
