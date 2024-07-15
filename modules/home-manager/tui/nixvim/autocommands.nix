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
    # {
    #   event = [
    #     "WinEnter"
    #     "BufEnter"
    #     "VimEnter"
    #   ];
    #   callback = {
    #     __raw = ''
    #       function()
    #         local current_win = vim.api.nvim_get_current_win()
    #         local wins = vim.api.nvim_list_wins()
    #         
    #         for _, win in ipairs(wins) do
    #           if win == current_win then
    #             -- Set highlight for active buffer
    #             vim.api.nvim_win_set_option(win, 'winhighlight', 'SignColumn:ActiveSignColumn')
    #           else
    #             -- Clear custom highlight for inactive buffers
    #             vim.api.nvim_win_set_option(win, 'winhighlight', 'SignColumn:')
    #           end
    #         end
    #       end
    #     '';
    #   };
    # }
  ];
}
