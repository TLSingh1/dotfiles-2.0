local ViMode = require("plugins.ui.heirline.components.vi-mode")
local FileNameBlock = require("plugins.ui.heirline.components.file")
local Diagnostics = require("plugins.ui.heirline.components.diagnostics")

local StatusLine = {
  ViMode,
  FileNameBlock,
  Diagnostics
}

return StatusLine
