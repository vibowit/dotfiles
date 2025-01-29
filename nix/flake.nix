{
  description = "My Nix Flake for macOS (nix-darwin) and Linux (Home Manager)";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    darwinConfigurations."MacLaren" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit self; };
      modules = [ ./nix/nix-darwin/darwin-configuration.nix ];
    };

    homeConfigurations."vibo-home" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home-manager/home.nix
        ./home-manager/modules/zsh.nix
        ./home-manager/modules/nvim.nix
      ];

      # Optionally use extraSpecialArgs
    };
  };
}
