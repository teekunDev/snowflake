#
#  anyrun home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ anyrun.nix *
#

{ pkgs, inputs, ... }:

{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        shell
        stdin
        websearch
      ];
      y.fraction = 0.4;
      width.fraction = 0.3;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
      * {
        color: #cdd6f4;
        font-family: Hack Nerd Font;
        font-size: 1.1rem;
        transition: none;
      }

      #window {
        background-color: rgba(17, 17, 27, 0.5);
      }

      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match:selected {
        background: rgba(203, 166, 247, 0.5);
      }

      #match {
        padding: 3px;
        border-radius: 8px;
      }

      #entry {
        border-radius: 8px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.5);
        border: 1px solid #28283d;
        border-radius: 14px;
        padding: 8px;
      }

      row:first-child {
        margin-top: 6px;
      }
    '';
    extraConfigFiles."applications.ron".text = ''
      Config(
        terminal: Some("kitty"),
      )
    '';
    extraConfigFiles."websearch.ron".text = ''
      Config(
        prefix: "?",
        engines: [DuckDuckGo]
      )
    '';
  };

  nix.settings = {
    builders-use-substitutes = true;
    substituters = [ "https://anyrun.cachix.org" ];
    trusted-public-keys = [ "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s=" ];
  };
}