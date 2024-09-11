#
#  flakey flake flake :nyaboom:
#
#  flake.nix *
#   └─ ./hosts
#       └─ hosts.nix +
#

{
  description = "A snowflake, just like me";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=ba696521930059aa489ac6ffabe28553edaf2fa3";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    xremap = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      vars = {
        user = "teekun";
        location = "/home/teekun/.snowflake";
        symlink = "/stuff/symlink";
        secrets = "/stuff/secrets";
        walldir = "/stuff/wall";
      };
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      nixosConfigurations = (
        import ./hosts/hosts.nix {
          inherit inputs vars;
        }
      );
    };
}
