{
  imports = [
    ./auto-session.nix
    ./bufferline.nix
    ./cmp.nix
    ./comment.nix
    ./dashboard.nix
    ./gitsigns.nix
    ./hop.nix
    ./indent-blankline.nix
    ./lsp.nix
    ./lualine.nix
    ./navic.nix
    ./navbuddy.nix
    ./neo-tree.nix
    ./noice.nix
    ./notify.nix
    ./project.nix
    ./rainbow-delimiters.nix
    ./telescope.nix
    ./todo-comments.nix
    ./toggleterm.nix
    ./ts-autotag.nix
    ./zen-mode.nix
  ];

  programs.nixvim.plugins = {
    image = {
      enable = true;
      backend = "kitty";
    };
    friendly-snippets.enable = true;
    treesitter = { enable = true; ensureInstalled = "all"; };
    treesitter-context.enable = true;
    treesitter-textobjects.enable = true;
    # comment.enable = true;
    ts-context-commentstring.enable = true;
    ts-autotag.enable = true;

    # TODO: uncomment below if none-ls trash
    conform-nvim.enable = true;
    nvim-autopairs.enable = true;
    surround.enable = true;
    smart-splits.enable = true;
    luasnip = {
      enable = true;
      extraConfig = {
        enable_autosnippets = true;
      };
    };

    none-ls = {
      enable = true;
      enableLspFormat = true;
    };
  };
}
