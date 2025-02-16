{ pkgs, nixvim, ... }:

{
  # inherit nixvim;
  imports = [
    ./pkgs.nix
    nixvim.homeManagerModules.nixvim
    ./modules/neovim.nix
    ../home-manager/zsh.nix
    ./modules/wezterm.nix
  ];

  home = {
    username = "vibowit";
    homeDirectory =
      if pkgs.stdenv.isDarwin
        then "/Users/vibowit"
      else "/home/vibowit";
    stateVersion = "24.11";
  };

  programs.git = {
    enable = true;
    userName = "vibowit";
    userEmail = "vibowit@gmail.com";
  };
}
