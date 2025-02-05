{ config, pkgs, ... }:

{

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

# colorschemes.catppuccin.enable = true;
    colorschemes.tokyonight.enable = true;
# colorscheme = "gruvbox";

    globals.mapleader = " ";
    clipboard.register = "unnamedplus";

# Set basic Neovim options
    opts = {
      number = true; 
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;

      # mapleader = " ";
    };

    # Define basic keybindings
    keymaps = [
      { mode = "n"; key = "<Space>"; action = ""; options.silent = true; } # Set space as leader key
      { mode = "n"; key = "<leader>w"; action = ":w<CR>"; }  # Save file with <leader>w
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; }  # Quit with <leader>q
      { mode = "i"; key = "jj"; action = "<Esc>"; }  # Exit insert mode with "jj"
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<CR>"; }
      { mode = "n"; key = "<leader>fg"; action = ":Telescope live_grep<CR>"; }
      { mode = "n"; key = "<leader><leader>"; action = ":Telescope buffers<CR>"; }
      { mode = "n"; key = "<leader>fh"; action = ":Telescope help_tags<CR>"; }
    ];

#
# # Define plugins
    plugins = {
      lualine.enable = true; # Status line
      telescope.enable = true; # Fuzzy finder
      which-key.enable = true; # Show keymaps
      gitsigns.enable = true; # Git indicators
      web-devicons.enable = true;
      lsp-format.enable = true;

# # Syntax highlighting
      treesitter = {
        enable = true; 
        # ensureInstalled = [ "lua" "python" "go" "nix" "bash" ];
        settings.ensure_installed = [ "lua" "python" "go" "nix" "bash" ];
      };

      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
          ];
        };
      };

# # Enable LSP with basic support
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          pyright.enable = true;
        };
      };
    };
  };
}
