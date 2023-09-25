#
#  mako home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ mako.nix *
#

{ host, ... }:

let
  output = with host; 
    if hostName == "desktop" then "DP-1"
    else if hostName == "laptop" then "eDP-1"
    else "";
in
{
  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    progressColor = "over #323244";
    borderColor = "#cba6f7";
    textColor = "#cdd6f4";
    borderRadius = 8;
    borderSize = 3;
    output = "${output}";
    defaultTimeout = 5000;
    margin = "20";
    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };
}