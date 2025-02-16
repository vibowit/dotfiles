{
  description = "My NixOS, MacBook and Home-Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, flake-utils, ... }@inputs:
    let
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
      forEachSystem = flake-utils.lib.eachSystem supportedSystems;
    in
    {
      # Define Home Manager configurations globally
      homeConfigurations.vibowit = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin"; # or dynamically detect
          config.allowUnfree = true;
        };
        modules = [ ./home/default.nix ];
        extraSpecialArgs = { inherit nixvim; };
      };

      # Define system-dependent outputs
      devShells = forEachSystem (system: {
        default = import ./shell/default.nix {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        };
      });
    };
}
