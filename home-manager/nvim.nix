{ config, pkgs, ... }:

{

  # most of this config is copied from https://github.com/JMartJonesy/kickstart.nixvim/tree/main

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfigLua = ''
      vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
      ]]
    '';

    colorschemes = {
      # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
      tokyonight = {
        enable = true;
        settings = {
          # Like many other themes, this one has different styles, and you could load
          # any other, such as 'storm', 'moon', or 'day'.
          style = "night";
        };
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };
    #  See `:help 'clipboard'`
    clipboard = {
      providers = {
        wl-copy.enable = true; # For Wayland
        xsel.enable = true; # For X11
      };

      # Sync clipboard between OS and Neovim
      #  Remove this option if you want your OS clipboard to remain independent.
      register = "unnamedplus";
    };

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
      showmode = false;

      # mapleader = " ";
    };

    # Define basic keybindings
    keymaps = [
      { mode = "n"; key = "<space>"; action = ""; options.silent = true; } # Set space as leader key
      { mode = "n"; key = "<leader>w"; action = ":w<CR>"; }  # Save file with <leader>w
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; }  # Quit with <leader>q
      { mode = "i"; key = "jj"; action = "<Esc>"; }  # Exit insert mode with "jj"
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<CR>"; }
      { mode = "n"; key = "<leader>fg"; action = ":Telescope live_grep<CR>"; }
      { mode = "n"; key = "<leader><leader>"; action = ":Telescope buffers<CR>"; }
      { mode = "n"; key = "<leader>fh"; action = ":Telescope help_tags<CR>"; }
    ];


    # Define plugins
    plugins = {
      lualine.enable = true; # Status line
      which-key.enable = true; # Show keymaps
      gitsigns.enable = true; # Git indicators
      web-devicons.enable = true; # Icons in status line
      lsp-format.enable = true;

      nvim-autopairs.enable = true;

      # Detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      sleuth = {
        enable = true;
      };

      # Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        settings = {
          enable = true;
          signs = true;
        };
      };
    
      # Syntax highlighting
      treesitter = {
        enable = true; 
        settings = {
          ensure_installed = [ "lua" "python" "go" "nix" "bash" "markdown" "markdown_inline" "diff" ];
          indent.enable = true;
        };
      };

      cmp = {
        enable = true;
        settings = {
          # For an understanding of why these mappings were
          # chosen, you will need to read `:help ins-completion`
          #
          # No, but seriously, Please read `:help ins-completion`, it is really good!
          mapping = {
            # Select the [n]ext item
            "<C-n>" = "cmp.mapping.select_next_item()";
            # Select the [p]revious item
            "<C-p>" = "cmp.mapping.select_prev_item()";
            # Scroll the documentation window [b]ack / [f]orward
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            # Accept ([y]es) the completion.
            #  This will auto-import if your LSP supports it.
            #  This will expand snippets if the LSP sent a snippet.
            "<C-y>" = "cmp.mapping.confirm { select = true }";

            # Manually trigger a completion from nvim-cmp.
            #  Generally you don't need this, because nvim-cmp will display
            #  completions whenever it has completion options available.
            "<C-Space>" = "cmp.mapping.complete {}";

            # Think of <c-l> as moving to the right of your snippet expansion.
            #  So if you have a snippet that's like:
            #  function $name($args)
            #    $body
            #  end
            #
            # <c-l> will move you to the right of the expansion locations.
            # <c-h> is similar, except moving you backwards.
            "<C-l>" = ''
            cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' })
            '';
            "<C-h>" = ''
            cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' })
            '';

            # For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            #    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          };
          sources = [
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };

      # Enable LSP with basic support
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          pyright.enable = true;
          nil_ls.enable = true;
          gopls.enable = true;
        };
      };

      telescope = {
        # Telescope is a fuzzy finder that comes with a lot of different things that
        # it can fuzzy find! It's more than just a "file finder", it can search
        # many different aspects of Neovim, your workspace, LSP, and more!
        #
        # The easiest way to use Telescope, is to start by doing something like:
        #  :Telescope help_tags
        #
        # After running this command, a window will open up and you're able to
        # type in the prompt window. You'll see a list of `help_tags` options and
        # a corresponding preview of the help.
        #
        # Two important keymaps to use while in Telescope are:
        #  - Insert mode: <c-/>
        #  - Normal mode: ?
        #
        # This opens a window that shows you all of the keymaps for the current
        # Telescope picker. This is really useful to discover what Telescope can
        # do as well as how to actually do it!
        #
        # [[ Configure Telescope ]]
        # See `:help telescope` and `:help telescope.setup()`
        enable = true;

        # Enable Telescope extensions
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };

        # You can put your default mappings / updates / etc. in here
        #  See `:help telescope.builtin`
        keymaps = {
          "<leader>sh" = {
            mode = "n";
            action = "help_tags";
            options = {
              desc = "[S]earch [H]elp";
            };
          };
          "<leader>sk" = {
            mode = "n";
            action = "keymaps";
            options = {
              desc = "[S]earch [K]eymaps";
            };
          };
          "<leader>sf" = {
            mode = "n";
            action = "find_files";
            options = {
              desc = "[S]earch [F]iles";
            };
          };
          "<leader>ss" = {
            mode = "n";
            action = "builtin";
            options = {
              desc = "[S]earch [S]elect Telescope";
            };
          };
          "<leader>sw" = {
            mode = "n";
            action = "grep_string";
            options = {
              desc = "[S]earch current [W]ord";
            };
          };
          "<leader>sg" = {
            mode = "n";
            action = "live_grep";
            options = {
              desc = "[S]earch by [G]rep";
            };
          };
          "<leader>sd" = {
            mode = "n";
            action = "diagnostics";
            options = {
              desc = "[S]earch [D]iagnostics";
            };
          };
          "<leader>sr" = {
            mode = "n";
            action = "resume";
            options = {
              desc = "[S]earch [R]esume";
            };
          };
          "<leader>s" = {
            mode = "n";
            action = "oldfiles";
            options = {
              desc = "[S]earch Recent Files ('.' for repeat)";
            };
          };
          "<leader><leader>" = {
            mode = "n";
            action = "buffers";
            options = {
              desc = "[ ] Find existing buffers";
            };
          };
        };
        settings = {
          extensions.__raw = "{ ['ui-select'] = { require('telescope.themes').get_dropdown() } }";
        };
      };
    };
  };
}
