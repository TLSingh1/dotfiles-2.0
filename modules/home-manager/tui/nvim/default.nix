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
    extraLuaPackages = luaPkgs:
      with luaPkgs; [
        tiktoken_core
      ];
    plugins = with pkgs.vimPlugins; [
      # Lazy
      lazy-nvim

      # AI
      copilot-vim
      avante-nvim

      # Coding
      nvim-treesitter.withAllGrammars
      ultimate-autopair-nvim
      luasnip
      friendly-snippets
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-cmdline
      cmp-emoji
      nvim-lspconfig
      none-ls-nvim
      conform-nvim
      lsp_lines-nvim
      nvim-surround
      better-escape-nvim
      todo-comments-nvim
      smart-splits-nvim
      typescript-tools
      # tailwind-tools
      nvim-ts-autotag
      # nvim-ts-context-commentstring
      # nvim-treesitter-context
      nvim-ufo

      # Git
      gitsigns-nvim
      diffview-nvim
      neogit

      # Project
      obsidian-nvim
      # neorg
      # neorg-templates
      # neorg-telescope
      # resession-nvim

      # UI
      plenary-nvim
      nui-nvim
      nuicomponents-nvim
      nvim-web-devicons
      neo-tree-nvim
      nvim-window-picker
      toggleterm-nvim
      telescope-nvim
      catppuccin-nvim
      # dashboard-nvim
      dressing-nvim
      nerdy-nvim
      indent-blankline-nvim
      rainbow-delimiters-nvim
      colorizer-nvim
      heirline-nvim
      nvim-notify
      nvim-tree-lua
      noice-nvim
      # nvim-navic
      # nvim-navbuddy
      # image-nvim
      # helpview-nvim
      # markview-nvim
      # colorful-winsep
      no-neck-pain-nvim
      # outline-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./lua/config/init.lua}

      require("lazy").setup({
        spec = {
          { import = "plugins" },
        },
        performance = {
          reset_packpath = false,
          rtp = {
            reset = false,
          }
        },
        dev = {
          path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
          patterns = { "" },
        },
        install = {
          missing = false,
        },
      })
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
