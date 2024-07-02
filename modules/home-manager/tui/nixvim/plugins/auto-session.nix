{
  programs.nixvim.plugins.auto-session = {
    enable = true;
    extraOptions = {
      session_lens = {
        load_on_setup = true;
        theme_conf = { border = true; };
        previewer = false;
        buftypes_to_ignore = {};
      };
    };
  };
}

