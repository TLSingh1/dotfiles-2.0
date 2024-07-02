{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      exclude = {
        filetypes = [
          "norg"
          "dashboard"
        ];
      };
      scope = {
        enabled = true;
        show_start = true;
        show_end = true;
        show_exact_scope = true;
      };
    };
  };
}
