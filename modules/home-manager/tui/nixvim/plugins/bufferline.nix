{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    bufferCloseIcon = "";
    modifiedIcon = "●";
    closeCommand = "bdelete! %d";
    colorIcons = true;
    diagnostics = "nvim_lsp";
    diagnosticsUpdateInInsert = false;
    enforceRegularTabs = true;
    leftMouseCommand = "buffer %d";
    rightMouseCommand = "bdelete! %d";
    leftTruncMarker = "";
    rightTruncMarker = "";
    maxNameLength = 18;
    maxPrefixLength = 15;
    numbers = "none";
    offsets = [
    {
      filetype = "neo-tree";
      text = "";
      text_align = "center";
      padding = 1;
      highlight = "ActiveWindow";
      separator = false;
    }
    ];
    persistBufferSort = true;
    separatorStyle = "thin";
    showBufferCloseIcons = true;
    showBufferIcons = true;
    showCloseIcon = true;
    showTabIndicators = true;
    tabSize = 20;
    themable = true;
  };
}
