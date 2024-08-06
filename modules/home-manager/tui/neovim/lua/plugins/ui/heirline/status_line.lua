local ViMode = require("plugins.ui.heirline.components.vi-mode")
local FileNameBlock = require("lua.plugins.ui.heirline.components.file")
-- local FC = require("plugins.ui.heirline.components.file")

local StatusLine = {
  ViMode,
  FileNameBlock,
}

return StatusLine
