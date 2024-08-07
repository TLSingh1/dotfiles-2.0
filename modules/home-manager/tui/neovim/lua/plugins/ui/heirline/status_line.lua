local ViMode = require("plugins.ui.heirline.components.vi-mode")
local FileNameBlock = require("plugins.ui.heirline.components.file")
local Diagnostics = require("plugins.ui.heirline.components.diagnostics")
local Git = require("plugins.ui.heirline.components.git")
local LineInfo = require("plugins.ui.heirline.components.line-info")

local Align = { provider = "%=" }
local Space = { provider = " " }

local LeftSection = {
  flexible = 1,
  {
    ViMode,
    Space,
    Space,
    Space,
    Diagnostics,
  },
  { provider = "" }, -- Empty provider as fallback
}

local MiddleSection = {
  flexible = 1,
  {
    Align,
    Space,
    Git,
  },
  { provider = "" }, -- Empty provider as fallback
}

local RightSection = {
  flexible = 1,
  {
    Align,
    FileNameBlock,
    Space,
    LineInfo
  },
  { provider = "" }, -- Empty provider as fallback
}

local StatusLine = {
  LeftSection,
  MiddleSection,
  RightSection,
}

return StatusLine
