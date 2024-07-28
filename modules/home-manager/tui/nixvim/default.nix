{ pkgs, ...}:
{
  imports = [
    ./autocommands.nix
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.catppuccin = {
      enable = true;
    };
    colorschemes.onedark = {
      enable = false;
    };
    colorschemes.tokyonight = {
      enable = false;
    };
    colorschemes.cyberdream = {
      enable = false;
      settings = {
        transparent = true;
        italic_comments = true;
        theme.highlights = {
          ActiveWindow.bg = "#16181A";
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      neorg
      neorg-telescope
      winbar-nvim
      colorful-winsep
      nvim-web-devicons
      markdown-nvim
      typescript-tools
      tailwind-tools
      yazi-nvim
      gen-nvim
      # incline
      # tailwindcss-colorizer-cmp
      # tw-values
    ];
    extraPackages = with pkgs; [
      imagemagick
    ];
    extraLuaPackages = luaPkgs: with luaPkgs; [
      lua-utils-nvim
      nvim-nio
      pathlib-nvim
      magick
    ];

    extraFiles = {
      "lua/config/init.lua" = builtins.readFile ./lua/config/init.lua;
      "lua/plugins/init.lua" = builtins.readFile ./lua/plugins/init.lua;
      "lua/plugins/neorg.lua" = builtins.readFile ./lua/plugins/neorg.lua;
      "lua/plugins/colorful-winsep.lua" = builtins.readFile ./lua/plugins/colorful-winsep.lua;
      "lua/plugins/web-devicons.lua" = builtins.readFile ./lua/plugins/web-devicons.lua;
      "lua/plugins/lualine.lua" = builtins.readFile ./lua/plugins/lualine.lua;
      "lua/plugins/render-markdown.lua" = builtins.readFile ./lua/plugins/render-markdown.lua;
      "lua/plugins/lsp/init.lua" = builtins.readFile ./lua/plugins/lsp/init.lua;
      "lua/plugins/typescript-tools.lua" = builtins.readFile ./lua/plugins/typescript-tools.lua;
      "lua/plugins/tailwind-tools.lua" = builtins.readFile ./lua/plugins/tailwind-tools.lua;
      "lua/plugins/ufo.lua" = builtins.readFile ./lua/plugins/ufo.lua;
      "lua/plugins/yazi.lua" = builtins.readFile ./lua/plugins/yazi.lua;
      "lua/plugins/gen.lua" = builtins.readFile ./lua/plugins/gen.lua;
    };
    extraConfigLua = builtins.readFile ./lua/init.lua;

    extraConfigLuaPost = ''
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e2f", fg = "#1e1e2f" })
      vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { bg = "#1e1e2f", fg = "#1e1e2f" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#313245", bg = "#000000" })

      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F38BA9" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F9E2B0" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89B4FB" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FAB388" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#A6E3A2" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CBA6F8" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      
      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup { scope = { highlight = highlight } }
      
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- Set the width (0-1 for percentage, >1 for absolute column count)
              width = 0.6,
              -- Set the height (0-1 for percentage, >1 for absolute row count)
              height = 0.6,
              -- You can add other layout_config options here as well
            }
          }
        }
      }
      require("telescope").load_extension("ui-select")
    '';
  };
}
