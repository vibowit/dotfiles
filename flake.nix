{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos-base = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          nvim/flake.nix
        ];
      };
    };

    homeConfigurations = {
      vibo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nvf.homeManagerModules.default
          ./home.nix
        ];
      };
    };
  };
}
