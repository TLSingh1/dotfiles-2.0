{ pkgs, config, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [

      # Coding
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      hop-nvim
      comment-nvim

      # Git

      # Project

      # UI
      plenary-nvim
      nui-nvim
      nvim-web-devicons
      neo-tree-nvim
      nvim-window-picker
      toggleterm-nvim
      bufferline-nvim
      telescope-nvim
      catppuccin-nvim
      dashboard-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./lua/config/init.lua}
      ${builtins.readFile ./lua/plugins/init.lua}
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
