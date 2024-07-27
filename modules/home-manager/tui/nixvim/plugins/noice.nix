{
  programs.nixvim.plugins.noice = {
    enable = true;
    routes = [
      {
        view = "mini";
        filter = { find = "written"; };
        opts = { skip = true; };
      }
      {
        filter = { find = "Failed to attach to nixd"; };
        opts = { skip = true; };
      }
      {
        filter = { find = "Failed to attach to nil_ls"; };
        opts = { skip = true; };
      }
    ];
    views = {
      cmdlinePopup = {
        border = {
          style = "none";
          padding = [ 1 2 ];
        };
        filter_options = {};
        position = {
          row = "50%";
          col = "50%";
        };
        size = {
          width = 40;
          height = "auto";
        };
      };
    };
    presets = {
      commandPalette = false;
      lspDocBorder = false;
      inc_rename = true;
    };
  };
}
