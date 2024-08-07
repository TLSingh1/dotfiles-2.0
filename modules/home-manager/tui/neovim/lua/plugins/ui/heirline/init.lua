local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")

local TabLine    = require("plugins.ui.heirline.tab_line")
local WinBar     = require("plugins.ui.heirline.winbar")

require("heirline").setup({
  statusline = TabLine,
  winbar = WinBar,
  opts = {
    disable_winbar_cb = function(args)
      return conditions.buffer_matches({
        buftype = {
          "nofile",
          "prompt",
          "help",
          "quickfix"
        },
        filetype = {
          "^git.*",
          "dashboard",
          "neo-tree",
          "toggleterm",
        }
      }, args.buf)
    end
  },
  -- winbar = { ... },
  -- tabline = TabLine
  -- statuscolumn = { ... },
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
