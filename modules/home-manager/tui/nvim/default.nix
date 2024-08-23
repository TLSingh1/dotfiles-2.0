{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      # Lazy
      lazy-nvim
      which-key-nvim

      # AI
      # claude-nvim
      # copilot-vim
      # avante-nvim

      # Coding
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.svelte
      # comment-nvim
      # nvim-autopairs
      # ultimate-autopair-nvim
      # luasnip
      # friendly-snippets
      # nvim-cmp
      # cmp-nvim-lsp
      # cmp-buffer
      # cmp-path
      # cmp_luasnip
      # cmp-cmdline
      # cmp-emoji
      # nvim-lspconfig
      # none-ls-nvim
      # lsp-format-nvim
      # conform-nvim
      # lsp_lines-nvim
      # nvim-surround
      # better-escape-nvim
      # todo-comments-nvim
      # smart-splits-nvim
      # typescript-tools
      # tailwind-tools
      # nvim-ts-autotag
      # nvim-ts-context-commentstring
      # nvim-treesitter-context
      # marks-nvim
      # nvim-ufo

      # Git
      # gitsigns-nvim
      # diffview-nvim
      # neogit

      # Project
      # neorg
      # neorg-templates
      # neorg-telescope
      # resession-nvim

      # UI
      # plenary-nvim
      # nui-nvim
      # nuicomponents-nvim
      # nvim-web-devicons
      # neo-tree-nvim
      # nvim-window-picker
      # toggleterm-nvim
      # telescope-nvim
      # catppuccin-nvim
      # dashboard-nvim
      # dressing-nvim
      # nerdy-nvim
      # indent-blankline-nvim
      # rainbow-delimiters-nvim
      # colorizer-nvim
      # heirline-nvim
      # nvim-notify
      # noice-nvim
      # nvim-navic
      # nvim-navbuddy
      # image-nvim
      # helpview-nvim
      # markview-nvim
      # colorful-winsep
      # no-neck-pain-nvim
      # outline-nvim
    ];
    extraLuaConfig = ''
      vim.g.mapleader = " "

      -- Set custom parser install directory
      vim.g.ts_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
      vim.fn.mkdir(vim.g.ts_install_dir, "p")
      vim.opt.runtimepath:append(vim.g.ts_install_dir)

      -- Set up Treesitter
      require('nvim-treesitter.configs').setup {
        parser_install_dir = vim.g.ts_install_dir,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {},  -- We don't need to install anything, as we're using pre-compiled parsers
      }

      -- Manually load the Svelte parser
      local svelte_parser = vim.g.ts_install_dir .. "/svelte.so"
      if not vim.loop.fs_stat(svelte_parser) then
        vim.fn.system({"cp", "${pkgs.vimPlugins.nvim-treesitter-parsers.svelte}/parser/svelte.so", svelte_parser})
      end
      vim.treesitter.language.add('svelte', { path = svelte_parser })

      -- Lazy setup
      require("lazy").setup({
        spec = {
          { import = "plugins" },
        },
      }, {
        performance = {
          reset_packpath = false,
          rtp = {
            reset = false,
          }
        },
        dev = {
          path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
          patterns = {""},
        },
        install = {
          missing = false,
        },
      })

      -- Force Treesitter to load parsers
      vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = {"*.svelte"},
        callback = function()
          vim.cmd("TSEnable highlight")
        end
      })
    '';
    # extraLuaConfig = ''
    #   ${builtins.readFile ./lua/config/init.lua}
    #   ${builtins.readFile ./lua/plugins/init.lua}
    # '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
