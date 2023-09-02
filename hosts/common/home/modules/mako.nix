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

{
  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    progressColor = "over #323244";
    borderColor = "#cba6f7";
    textColor = "#cdd6f4";
    borderRadius = 8;
    borderSize = 3;
    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };
}