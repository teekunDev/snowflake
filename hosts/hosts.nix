#
#  These are the different profiles that can be used when building NixOS.
# 
#  flake.nix !
#   └─ ./hosts
#       ├─ hosts.nix *
#       └─ ./common AND ./desktop OR ./laptop
#            ├─ ./configuration
#            ├─  └─ configuration.nix +
#            └─ ./home 
#                └─ home.nix +
#

{ inputs, vars, ... }:

let
  system = "x86_64-linux";
  hmModule = inputs.home-manager.nixosModules.home-manager;
  hyprlandModule = inputs.hyprland.homeManagerModules.default;
  xremapModule = inputs.xremap.nixosModules.default;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in
{
  desktop = nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs vars;
      host = {
        hostName = "desktop";
        gpuIDs = [
          "10de:2484" # 3070 Graphics
          "10de:228b" # 3070 Audio
        ];
      };
    };
    modules = [
      ./common/configuration/configuration.nix
      ./desktop/configuration.nix
      xremapModule
      hmModule {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs vars;
            host.hostName = "desktop";
          };
          users.${vars.user} = {
            imports = [
              ./common/home/home.nix
              ./desktop/home.nix
            ];
          };
        };
      }
    ];
  };
  laptop = nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs vars;
      host = {
        hostName = "laptop";
        gpuIDs = [
          "10de:2520" # 3060 Mobile Graphics
          "10de:228e" # 3060 Mobile Audio
        ];
      };
    };
    modules = [
      ./common/configuration/configuration.nix
      ./laptop/configuration.nix
      xremapModule
      hmModule {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs vars;
            host.hostName = "laptop";
          };
          users.${vars.user} = {
            imports = [
              ./common/home/home.nix
              ./laptop/home.nix
            ];
          };
        };
      }
    ];
  };
  server = nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs vars;
      host.hostName = "server";
    };
    modules = [
      ./server/configuration.nix
    ];
  };
}
