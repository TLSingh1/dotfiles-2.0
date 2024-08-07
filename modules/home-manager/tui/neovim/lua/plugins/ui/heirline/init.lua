-- local StatusLine = require("plugins.ui.heirline.status_line")
local TabLine = require("plugins.ui.heirline.tab_line")
local WinBar  = require("plugins.ui.heirline.winbar")

require("heirline").setup({
  statusline = TabLine,
  winbar = WinBar,
  -- winbar = { ... },
  -- tabline = TabLine
  -- statuscolumn = { ... },
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
