{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      change_to_vcs_root = true;
      theme = "doom";
      project.eable = true;
      shortcut_type = "number";
      hide = {
        tabline = true;
        statusline = true;
      };
      config = {
        disable_move = true;
        header = [
          "                                            "
          "                                            "
          "                                            "
          "                                            "
          "                                            "
          "                                            "
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
          "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          "                                            "
          "                                            "
          "                                            "
          "                                            "
          "                                            "
          "                                            "
        ];
        center = [
          {
            icon = "💰  ";
            desc = "Brain";
            action = ":cd ~/Brain/ | e index.norg";
            key = "b";
          }
          # {
          #   icon = "🔎  ";
          #   desc = "Find File";
          #   action = "lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))";
          #   key = "f";
          # }
          {
            icon = "🔎  ";
            desc = "Project Grep";
            action = "Telescope projects";
            key = "p";
          }
          {
            icon = "🧬  ";
            desc = "Dotfyles";
            action = ":cd ~/.dotfiles/ | e flake.nix";
            key = "d";
          }
          {
            icon = "⏳  ";
            desc = "Sessions";
            action = "Telescope session-lens";
            key = "s";
          }
          {
            icon = "🥷  ";
            desc = "Quit Nvim";
            action = "qa";
            key = "q";
          }
        ];
        footer = [
          ""
        ];
      };
    };
  };
}
