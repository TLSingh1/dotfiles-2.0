{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
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
      
      require("lazy").setup({
        spec = {
          { import = "plugins" },
        },
      }, {
        performance = {
          reset_packpath = false,
          rtp = {
            reset = false,
          }
        },
        dev = {
          path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
          patterns = {
            "nvim-treesitter",
            "akinsho",
            "utilyre",
            "SmiteshP",
            "nvim-neo-tree",
          },
        },
        install = {
          missing = false,
        },
      })
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
