{ configs, pkgs, lib, nixvim, ... }: {
  imports = [
    nixvim.homeManagerModules.nixvim
    ./zsh.nix
    ./nvim.nix # nixvim configs
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "vibo";
    homeDirectory = "/home/vibo";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bat
    pkgs.fd
    pkgs.ripgrep
    pkgs.unzip
    pkgs.rsync
    #pkgs.nerd-fonts.meslo-lg
    #pkgs.nerd-fonts.jetbrains-mono
    pkgs.wl-clipboard

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = lib.mkDefault "vim";
  };

  programs = {
    gh = {
      enable = true;
      settings = {
        version = "1";
        aliases = {
          "as" = "auth status";
        };
      };
    };

    git = {
      enable = true;
      extraConfig = {
        user.name = "vibowit";
        user.email = "vibowit@gmail.com";
        init.defaultBranch = "main";
      };
    };

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

