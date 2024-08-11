local utils = require("heirline.utils")

local LineInfo = {
	init = function(self)
		self.line = vim.fn.line(".")
		self.total_lines = vim.fn.line("$")
		self.col = vim.fn.virtcol(".")
	end,

	flexible = 1,

	-- {
	-- 	-- Full version
	-- 	provider = function(self)
	-- 		return string.format("%d : %d | %d ", self.line, self.total_lines, self.col)
	-- 	end,
	-- },
	{
		-- Medium version (no total lines)
		provider = function(self)
			return string.format("%d | %d ", self.line, self.total_lines)
		end,
	},
	-- {
	-- 	-- Minimal version (only line number)
	-- 	provider = function(self)
	-- 		return tostring(self.line)
	-- 	end,
	-- },
	hl = {
		fg = "#F5C2E8",
		bold = true,
	},

	-- hl = function()
	-- 	return utils.get_highlight("@character.special")
	-- end,
	-- hl = { fg = "#94e2d6", bold = true },
}

return LineInfo
