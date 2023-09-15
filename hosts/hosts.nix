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

{ inputs, nixpkgs, user, location, symlink, secrets, ... }:

let
  system = "x86_64-linux";
in
{
  desktop = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system user location symlink secrets;
      host = {
        hostName = "desktop";
        # 3070
        gpuIDs = [
          "10de:2484" # Graphics
          "10de:228b" # Audio
        ];
      };
    };
    modules = [
      inputs.nur.nixosModules.nur
      ./common/configuration/configuration.nix
      ./desktop/configuration.nix
      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs user location symlink secrets;
          host = {
            hostName = "desktop";
          };
        };
        home-manager.users.${user} = {
          imports = [
            inputs.anyrun.homeManagerModules.default
            ./common/home/home.nix
            ./desktop/home.nix
          ];
        };
      }
    ];
  };
  laptop = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system user location symlink secrets;
      host = {
        hostName = "laptop";
        # 3060 Mobile
        gpuIDs = [
          "10de:2520" # Graphics
          "10de:228e" # Audio
        ];
      };
    };
    modules = [
      inputs.nur.nixosModules.nur
      ./common/configuration/configuration.nix
      ./laptop/configuration.nix
      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs user location symlink secrets;
          host = {
            hostName = "laptop";
          };
        };
        home-manager.users.${user} = {
          imports = [
            inputs.anyrun.homeManagerModules.default
            ./common/home/home.nix
            ./laptop/home.nix
          ];
        };
      }
    ];
  };
}
