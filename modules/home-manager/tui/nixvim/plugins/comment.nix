{
  programs.nixvim.plugins.comment = {
    enable = true;
    settings = {
      toggler = {
        line = ",";
      };
      pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
    };
  };
}
