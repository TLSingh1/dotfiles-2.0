{
  programs.nixvim.plugins.indent-blankline = {
    enable = false;
    settings = {
      exclude = {
        filetypes = [
          "norg"
          "dashboard"
          "alpha"
        ];
      };
      # scope = {
      #   enabled = false;
      #   show_start = true;
      #   show_end = true;
      #   show_exact_scope = true;
      # };
    };
  };
}
