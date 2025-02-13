{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:
    let
      #system = "x86_64-linux";
      isDarwin = pkgs.stdenv.isDarwin;
      system = (if isDarwin then "aarch64-darwin" else "x86_64-linux");
      pkgs = import nixpkgs {inherit system;};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos-base = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/base.nix ];
        };

        marina-nix = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/marina-nix.nix ];
        };
      };

      homeConfigurations = {
        vibowit = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit nixvim;};
          modules = [
            ./home-manager/vibowit.nix
          ];
        };
      };
    };
}
