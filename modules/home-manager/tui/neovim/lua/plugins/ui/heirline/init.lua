local StatusLine = require("plugins.ui.heirline.status_line")

require("heirline").setup({
  statusline = StatusLine,
  -- winbar = { ... },
  -- tabline = { ... },
  -- statuscolumn = { ... },
})
