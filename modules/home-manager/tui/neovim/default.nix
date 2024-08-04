{ pkgs, config, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      plenary-nvim
      nui-nvim
      nvim-web-devicons
      neo-tree-nvim
      toggleterm-nvim
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
