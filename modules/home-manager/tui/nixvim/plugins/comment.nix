{
  programs.nixvim.plugins.comment = {
    enable = true;
    settings = {
      toggler = {
        line = "gcc";
        block = "gbc";
      };
      opleader = {
        line = "gc";
        block = "gb";
      };
      mappings = {
        basic = true;
      };
      pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
    };
  };
}
