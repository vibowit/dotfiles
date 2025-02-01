{
  config,
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim"; # Set Neovim as default editor
  };

  # home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/nvim";

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
          cursorline = true;
          ignorecase = true;
          smartcase = true;
          showmode = false;
        };

        utility.icon-picker.enable = true;

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;

          bash.enable = true;
          go.enable = true;
          lua.enable = true;
          python.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "tokyonight";
          };
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;
        useSystemClipboard = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = false;
          };
        };

        tabline = {
          nvimBufferline.enable = false;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
