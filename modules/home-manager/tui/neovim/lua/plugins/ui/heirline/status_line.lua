local ViMode = require("plugins.ui.heirline.components.vi-mode")
local FileNameBlock = require("plugins.ui.heirline.components.file")
local Diagnostics = require("plugins.ui.heirline.components.diagnostics")
local Git = require("plugins.ui.heirline.components.git")

local Align = { provider = "%=" }
local Space = { provider = " " }

local LineInfo = {
  provider = function()
    local line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local col = vim.fn.virtcol('.')
    return string.format("%d/%d:%d", line, total_lines, col)
  end,
  hl = { fg = "gray", bold = true },
}

local StatusLine = {
  {
    ViMode,
    Space,
    FileNameBlock,
    Space,
    Diagnostics,
    Align
  },
  {
    Git,
    Align
  },
  {
    LineInfo, -- Add the new LineInfo component here
    Space
  }
}

return StatusLine
