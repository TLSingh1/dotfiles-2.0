{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter.withAllGrammars
      plenary-nvim
      nui-nvim
      nvim-web-devicons
      neo-tree-nvim
      toggleterm-nvim
      barbecue-nvim
      nvim-navic
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


      require("nvim-treesitter.configs").setup({
      	auto_install = false,
      	indent = {
      		enable = true,
      		disable = { "python", "yaml" },
      	},
      	highlight = {
      		enable = true,
      		disable = { "yaml" }, -- Disable yaml highlighting because Helm sucks :<
      		additional_vim_regex_highlighting = false,
      	},
      })

      vim.notify("hello")

    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
}
