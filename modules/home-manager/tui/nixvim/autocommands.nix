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
            vim.api.nvim_set_hl(0, 'LineNr', { fg = "#011826" }) 
            vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#011826" }) 
          end
        '';
      };
    }
  ];
}
