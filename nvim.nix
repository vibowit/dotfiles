{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    # pkgs.cowsay
    ripgrep
    gcc
  ];

  home.sessionVariables = {
    EDITOR = "nvim";  # Set Neovim as default editor
  };

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/nvim";
}
