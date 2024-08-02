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
require("ibl").setup {
  scope = { highlight = highlight },
  exclude = {
    filetypes = {
      "dashboard",
      "alpha",
      "starter",
    },
  },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
