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
  inherit (inputs.nixpkgs.lib) nixosSystem;
in
{
  desktop = nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs vars;
      host = {
        hostName = "desktop";
      };
    };
    modules = [
      ./common/configuration/configuration.nix
      ./desktop/configuration.nix
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
      };
    };
    modules = [
      ./common/configuration/configuration.nix
      ./laptop/configuration.nix
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
