-- ./lua/modules/ui/toggleterm.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "toggleterm.nvim",
  keys = {
    { "<A-;>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Toggle terminal" },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = "<A-;>",
      direction = "float",
      shell = "fish",
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          guifg = "#011826",
          guibg = "#011826",
        },
      },
    })
  end,
})
