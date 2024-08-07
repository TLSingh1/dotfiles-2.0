local StatusLine = require("plugins.ui.heirline.status_line")
local TabLine = require("plugins.ui.heirline.tab_line")

require("heirline").setup({
  statusline = StatusLine,
  -- winbar = { ... },
  tabline = TabLine
  -- statuscolumn = { ... },
})

vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
