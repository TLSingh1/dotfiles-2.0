{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "[[<M-;>]]";
      direction = "float";
      on_open = ''
        function()
          vim.opt.winhighlight = "Normal:ActiveWindow"
          vim.api.nvim_command('highlight FloatBorder guifg=#222436 guibg=#222436')
        end
      '';
      shell = "fish";
      float_opts = {
        border = "curved";
        winblend = 0;
        highlights = {
          border = "Normal";
          background = "Normal";
        };
      };
    };
  };
}
