{
  programs.nixvim.plugins.navbuddy = {
    enable = true;
    lsp.autoAttach = true;
    window = {
      border = "rounded";
    };
    sourceBuffer = {
      followNode = false;
      highlight = false;
    };
  };
}
