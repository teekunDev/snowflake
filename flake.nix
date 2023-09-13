#
#  flakey flake flake :nyaboom:
#
#  flake.nix *
#   └─ ./hosts
#       └─ hosts.nix
#

{
  description = "NixOS :3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    xremap-flake.url = "github:xremap/nix-flake";
    anyrun.url = "github:Kirottu/anyrun";
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      user = "keifufu";
      location = "/home/keifufu/.nixos-config";
      symlink = "/stuff/symlink";
      secrets = "/stuff/secrets";
    in {
      nixosConfigurations = (
        import ./hosts/hosts.nix {
          inherit inputs nixpkgs user location symlink secrets;
        }
      );
    };
}
