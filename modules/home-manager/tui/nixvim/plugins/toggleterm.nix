{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "[[<M-;>]]";
      direction = "float";
      on_open = ''
        function()
          vim.opt.winhighlight = "Normal:ActiveWindow"
          vim.api.nvim_command('highlight FloatBorder guifg=#011826 guibg=#011826')
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
