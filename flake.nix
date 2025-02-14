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
      # system = "aarch64-darwin";  # Fallback to Linux if not explicitly set
      # system = builtins.trace "Detected system: ${builtins.currentSystem}" builtins.currentSystem;
      # system = builtins.currentSystem;  # Fallback to Linux if not explicitly set
      system = builtins.currentSystem;
      pkgs = import nixpkgs {inherit system;};
      # system = (if isDarwin then "aarch64-darwin" else "x86_64-linux");
    in {
      nixosConfigurations = {
        nixos-base = lib.nixosSystem {
          inherit system pkgs;
          modules = [ ./hosts/base.nix ];
        };

        marina-nix = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/marina-nix.nix ];
        };
      };

      homeConfigurations = {
        vibowit = home-manager.lib.homeManagerConfiguration {
          # inherit system;
          inherit pkgs;
          extraSpecialArgs = {inherit nixvim;};
          modules = [
            ./home-manager/vibowit.nix
          ];
        };
      };
    };
}
