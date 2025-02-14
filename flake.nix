{
  description = "My NixOS and Homw-Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos-base = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./hosts/base.nix
            ({ config, pkgs, ...}: {
              nixpkgs.pkgs = nixpkgs.legacyPackages.${config.nixpkgs.system};
            })
          ];
        };

        marina-nix = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/marina-nix.nix ];
        };
      };

      homeConfigurations.vibowit = home-manager.lib.homeManagerConfiguration {
        # system = "aarch64-darwin";
        pkgs = import nixpkgs {};
        # inherit system;
        extraSpecialArgs = {inherit nixvim;};
        modules = [
          ./home-manager/vibowit.nix
        ];
      };
    };
}
