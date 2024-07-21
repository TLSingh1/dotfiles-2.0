{
  programs.nixvim.plugins.image = {
    enable = true;
    backend = "kitty";
    integrations = {
      markdown = {
        enabled = true;
        clearInInsertMode = false;
        downloadRemoteImages = true;
        onlyRenderImageAtCursor = true;
        filetypes = [
          "markdown"
          "vimwiki"
        ];
      };
      neorg = {
        enabled = true;
        clearInInsertMode = false;
        downloadRemoteImages = true;
        onlyRenderImageAtCursor = true;
        filetypes = [
          "norg"
        ];
      };
    };
  };
}
