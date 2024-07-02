{
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    lspkind = {
      enable = true;
      cmp.enable = true;
    };
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        cssls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        marksman.enable = true;
        nil-ls.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        svelte.enable = true;
        tailwindcss.enable = true;
        tsserver.enable = true;
      };
    };
  };
}
