local path = require("plenary.path")
local devicons = require("nvim-web-devicons")
local Diagnostics = require("plugins.ui.heirline.components.diagnostics")
local LineInfo = require("plugins.ui.heirline.components.line-info")

local Align = { provider = "%=" }
local Space = { provider = " " }

local FileNameModifer = {
	provider = function()
		if vim.bo.modified then
			-- return " "
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
			-- Get the full path of the current buffer
			self.filename = vim.api.nvim_buf_get_name(0)

			-- Get the current working directory
			self.cwd = vim.fn.getcwd()

			-- Get relative path from cwd
			self.rel_path = path:new(self.filename):make_relative(self.cwd)

			-- Split the path
			self.parts = vim.split(self.rel_path, path.path.sep)

			-- Get file icon
			local filename = self.parts[#self.parts]
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
		end,

		-- CWD indicator
		-- {
		-- 	provider = function(self)
		-- 		return " " .. vim.fn.fnamemodify(self.cwd, ":t") .. " "
		-- 	end,
		-- 	hl = { fg = "blue", bold = true },
		-- },

		-- Path segments
		{
			provider = function(self)
				local segments = {}
				for i, part in ipairs(self.parts) do
					if i == #self.parts then
						break -- Skip the last part (filename)
					end
					table.insert(segments, part)
				end
				return table.concat(segments, "  ") .. (next(segments) and "  " or "")
			end,
			hl = { fg = "gray" },
		},

		-- File icon
		{
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		},

		-- File name
		{
			provider = function(self)
				return self.parts[#self.parts]
			end,
			hl = { fg = "white", bold = true },
		},
		{
			Space,
			FileNameModifer,
		},
		{
			Align,
			Space,
			Diagnostics,
			Space,
			LineInfo,
		},
	},
}

return WinBar
