{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      # AI
      claude-nvim

      # Coding
      nvim-treesitter.withAllGrammars
      hop-nvim
      comment-nvim
      nvim-autopairs
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
      lsp-format-nvim
      conform-nvim
      lsp_lines-nvim
      nvim-surround
      better-escape-nvim
      todo-comments-nvim
      smart-splits-nvim
      typescript-tools
      tailwind-tools
      nvim-ts-autotag
      nvim-ts-context-commentstring
      nvim-treesitter-context
      marks-nvim
      nvim-ufo

      # Git
      gitsigns-nvim
      diffview-nvim
      neogit

      # Project
      neorg
      neorg-templates
      neorg-telescope
      resession-nvim

      # UI
      plenary-nvim
      nui-nvim
      nvim-web-devicons
      neo-tree-nvim
      nvim-window-picker
      toggleterm-nvim
      bufferline-nvim
      telescope-nvim
      catppuccin-nvim
      dashboard-nvim
      dressing-nvim
      nerdy-nvim
      indent-blankline-nvim
      rainbow-delimiters-nvim
      colorizer-nvim
      lualine-nvim
      heirline-nvim
      nvim-notify
      noice-nvim
      nvim-navic
      nvim-navbuddy
      image-nvim
      helpview-nvim
      markview-nvim
      colorful-winsep
      no-neck-pain-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./lua/config/init.lua}
      ${builtins.readFile ./lua/plugins/init.lua}
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
