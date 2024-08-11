local ViMode = require("plugins.ui.heirline.components.vi-mode")
local FileNameBlock = require("plugins.ui.heirline.components.file")
local Diagnostics = require("plugins.ui.heirline.components.diagnostics")
local Git = require("plugins.ui.heirline.components.git")

local Align = { provider = "%=" }
local Space = { provider = " " }

local LineInfo = {
	provider = function()
		local line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local col = vim.fn.virtcol(".")
		return string.format("%4d:%-3d | %d", col, line, total_lines)
	end,
	hl = { fg = "#94e2d6", bold = true },
}

local LeftSection = {
	flexible = 1,
	{
		ViMode,
		Space,
		Space,
		FileNameBlock,
		Space,
	},
	{ provider = "" }, -- empty provider as fallback
}

local RightSection = {
	flexible = 1,
	{
		Diagnostics,
		LineInfo,
	},
	{ provider = "" }, -- same ^
}

local StatusLine = {
	LeftSection,
	{
		Align,
		Space,
		Git,
	},
	Align,
	RightSection,
}

return StatusLine
