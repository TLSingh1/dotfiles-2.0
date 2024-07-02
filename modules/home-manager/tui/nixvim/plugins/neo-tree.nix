{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    enableDiagnostics = true;
    enableGitStatus = true;
    addBlankLineAtTop = true;
    hideRootNode = false;
    popupBorderStyle = "rounded";
    retainHiddenRootIndent = true;
    closeIfLastWindow = true;
    buffers.followCurrentFile.enabled = true;
    filesystem = {
      followCurrentFile.enabled = true;
      useLibuvFileWatcher = true;
    };
    window = {
      mappings = {
        "<space>" = {
          command = "toggle_node";
          nowait = false;
        };
        "l" = { command = "open"; };
        "h" = { command = "close_node"; };
        "C" = { command = "close_all_nodes"; };
        "E" = { command = "expand_all_nodes"; };
        
      };
      position = "float";
      width = 25;
      popup = {
        size = {
          height = "30";
          width = "30";
        };
        position = "50%";
      };
      mappings = {
        "z" = "close_window";
      };
    };
    extraOptions = {
      sourceSelector = {
        winbar = true;
        sources = [
        {
          source = "filesystem";
          display_name = "𐎾    𐏃    𐏁    𐎠    𐎲 ";
        }
        ];
      };
    };
  };
}
