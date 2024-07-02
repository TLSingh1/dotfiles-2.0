{
  programs.nixvim.plugins.telescope = {
    enable = true;
    highlightTheme = "cyberdream";
    extensions = {
      fzf-native.enable = true;
    };
    settings = {
      defaults = {
        prompt_prefix = "🔭 ";
        selection_caret = " ";
        path_display = [ "smart" ];
        sorting_strategy = "ascending";
        mappings = {
          i = {
            "<esc>" = {
              __raw = "require('telescope.actions').close";
            };
            "<C-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "<C-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
            "<S-j>" = {
              __raw = "require('telescope.actions').preview_scrolling_down";
            };
            "<S-k>" = {
              __raw = "require('telescope.actions').preview_scrolling_up";
            };
          };
          n = {
            "j" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "k" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };
      };
    };
  };
}
