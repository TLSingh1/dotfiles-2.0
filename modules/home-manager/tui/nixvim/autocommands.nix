{
  programs.nixvim.autoCmd = [
    {
      event = [
        "FileType"
          "BufEnter"
      ];
      pattern = "*.norg";
      callback = {
        __raw = ''
          function()
            vim.api.nvim_set_hl(0, 'LineNr', { fg = "#16181a" }) 
            vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#16181a" }) 
          end
        '';
      };
    }
  ];
}
