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
    colorschemes.onedark = {
      enable = false;
    };
    colorschemes.tokyonight = {
      enable = true;
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
      # incline
      nvim-web-devicons
      markdown-nvim
      typescript-tools
      tailwind-tools
      yazi-nvim
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
    };
    extraConfigLua = builtins.readFile ./lua/init.lua;

    extraConfigLuaPost = ''
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#222436", fg = "#222436" })
    '';
  };
}
