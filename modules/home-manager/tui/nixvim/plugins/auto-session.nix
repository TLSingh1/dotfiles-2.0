{
  programs.nixvim.plugins.auto-session = {
    enable = true;
    extraOptions = {
      autoRestore.enabled = false;
      autoSave.enabled = false;
      autoSession = {
        enabled = true;
        enableLastSession = true;
        useGitBranch = true;
      };
      session_lens = {
        load_on_setup = true;
        theme_conf = { border = true; };
        previewer = false;
        buftypes_to_ignore = {};
      };
    };
  };
}

