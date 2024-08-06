local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local vi_mode = require("heirline.components.vi_mode")

local StatusLine = {
  { vi_mode },
}

-- local StatusLine = {
--   provider = function()
--     return "function"
--   end,
--   hl = function()
--     return {
--       fg = "#1affff",
--       bg = "#ff4444",
--     }
--   end
-- }

return StatusLine
