{ pkgs, nixvim, ... }:

{
  # inherit nixvim;
  imports = [
    ./pkgs.nix
    nixvim.homeManagerModules.nixvim
    ./modules/neovim.nix
    ./modules/zsh.nix
  ];

  home = {
    username = "vibowit";
    homeDirectory = "/Users/vibowit";
    stateVersion = "24.11";
  };

  programs.git = {
    enable = true;
    userName = "vibowit";
    userEmail = "vibowit@gmail.com";
  };

  # Environment variables
  home.sessionVariables = {
    GOPATH = "$HOME/go";
    PATH = "$GOPATH/bin:$PATH";
    CGO_ENABLED = "1";
    GOOS = "darwin";
  };

  # Direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
