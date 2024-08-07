local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")

local Diagnostics = {
	condition = function(self)
		return conditions.has_diagnostics(self.bufnr)
	end,

	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1],
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1],
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1],
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1],
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.INFO })

		self.error_icon = " "
		self.warn_icon = " "
		self.info_icon = " "
		self.hint_icon = " "
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = function(self)
			return self.errors > 0 and (self.error_icon .. self.errors .. " ") or ""
		end,
		hl = { fg = "#f38ba8" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") or ""
		end,
		hl = { fg = "#f9e2af" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ") or ""
		end,
		hl = { fg = "#89dceb" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints) or ""
		end,
		hl = { fg = "#94e2d5" },
	},
}

return Diagnostics
