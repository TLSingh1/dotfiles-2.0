local StatusLine = require("plugins.ui.heirline.status_line")
local TabLine = require("plugins.ui.heirline.tab_line")

require("heirline").setup({
  statusline = TabLine,
  -- winbar = { ... },
  -- tabline = TabLine
  -- statuscolumn = { ... },
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])