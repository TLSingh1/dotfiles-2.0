-- ./lua/modules/ui/toggleterm.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    { "n", "<A-;>", "<cmd>ToggleTerm<CR>",},
  },
  config = function()
    print("ToggleTerm plugin loaded!") -- Debug print
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
