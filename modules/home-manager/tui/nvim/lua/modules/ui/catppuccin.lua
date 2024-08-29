-- ./lua/modules/ui/catppuccin.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "catppuccin-nvim",  -- Changed from "catppuccin" to "catppuccin-nvim"
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
})
