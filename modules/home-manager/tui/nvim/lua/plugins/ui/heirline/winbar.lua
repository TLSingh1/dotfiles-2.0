local conditions = require("heirline.conditions")

local path = require("plenary.path")
local devicons = require("nvim-web-devicons")
local Diagnostics = require("plugins.ui.heirline.components.diagnostics")
local LineInfo = require("plugins.ui.heirline.components.line-info")

local Align = { provider = "%=" }
local Space = { provider = " " }

local FileNameModifer = {
	provider = function()
		if vim.bo.modified then
			return ""
		end
	end,
	hl = function()
		if vim.bo.modified then
			return { fg = "#EBA0AD", force = true }
		end
	end,
}

local WinBar = {
	fallthrough = false,
	{
		init = function(self)
			self.filename = vim.api.nvim_buf_get_name(0)
			self.cwd = vim.fn.getcwd()
			self.rel_path = path:new(self.filename):make_relative(self.cwd)
			self.parts = vim.split(self.rel_path, path.path.sep)
			local filename = self.parts[#self.parts]
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
		end,

		hl = function()
			if conditions.is_active() then
				return { bg = "#1E1E2F" }
			else
				return { bg = "#000000" }
			end
		end,

		-- path segments
		{
			provider = function(self)
				local segments = {}
				for i, part in ipairs(self.parts) do
					if i == #self.parts then
						break -- skip the last part (filename)
					end
					table.insert(segments, part)
				end
				return table.concat(segments, "  ") .. (next(segments) and "  " or "")
			end,
			hl = { fg = "gray" },
		},

		-- file icon
		{
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		},

		-- file name
		{
			provider = function(self)
				return self.parts[#self.parts]
			end,
			hl = { fg = "white", bold = true },
		},
		{
			Space,
			FileNameModifer,
			Space,
			Space,
			Diagnostics,
		},
		{
			Align,
			Space,
			Space,
			LineInfo,
		},
	},
}

return WinBar
