{
  pkgs,
  inputs,
  # config,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    # vimAlias = true;
    # vimdiffAlias = true;
    withNodeJs = true;
    extraLuaPackages = luaPkgs:
      with luaPkgs; [
        tiktoken_core
        magick
      ];
    plugins = with pkgs.vimPlugins; [
      # AI
      copilot-vim
      codecompanion-nvim
      # avante-nvim

      # Coding
      nvim-treesitter.withAllGrammars
      ultimate-autopair-nvim
      fast-cmp
      luasnip
      friendly-snippets
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-cmdline
      cmp-emoji
      nvim-lspconfig
      none-ls-nvim
      conform-nvim
      nvim-surround
      # better-escape-nvim
      # todo-comments-nvim
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
      # obsidian-nvim
      neorg
      # neorg-templates
      # neorg-telescope
      # resession-nvim

      # UI
      plenary-nvim
      nui-nvim
      # nuicomponents-nvim
      nvim-web-devicons
      # neo-tree-nvim
      # nvim-window-picker
      toggleterm-nvim
      telescope-nvim
      catppuccin-nvim
      dashboard-nvim
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
      image-nvim
      diagram-nvim
      helpview-nvim
      # no-neck-pain-nvim
      render-markdown
      neominimap-nvim
    ];

    extraLuaConfig = builtins.readFile ./lua/core/init.lua;
    # extraLuaConfig = ''
    #   ${builtins.readFile ./lua/core/init.lua}
    # '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };

  home.activation = {
    linkTreesitterParsers = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ~/.local/share/nvim/treesitter-parsers
      ln -sf ${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}/parser/* ~/.local/share/nvim/treesitter-parsers/
    '';
  };
}
