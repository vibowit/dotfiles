{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    # nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    # nvf,
    ...
  }: let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs {inherit system;};
    #  lib = nixpkgs.lib;
    lib = import nixpkgs {inherit lib;};
  in {
    nixosConfigurations = {
      nixos-base = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          # nvim/flake.nix
        ];
      };
    };

    homeConfigurations = {
      vibo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit nixvim;};
        modules = [
          # nvf.homeManagerModules.default
          # nixvim.homeManagerModules.nixvim
          ./home-manager/vibo.nix
        ];
      };
    };
  };
}
