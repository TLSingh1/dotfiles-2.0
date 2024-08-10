local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")

local TabLine = require("plugins.ui.heirline.tab-line")
local WinBar = require("plugins.ui.heirline.winbar")
local StatusColumn = require("plugins.ui.heirline.status-column")

require("heirline").setup({
	statusline = TabLine,
	winbar = WinBar,
	statuscolumn = StatusColumn,
	opts = {
		disable_winbar_cb = function(args)
			return conditions.buffer_matches({
				buftype = {
					"nofile",
					"prompt",
					"help",
					"quickfix",
					"Navbuddy",
				},
				filetype = {
					"^git.*",
					"dashboard",
					"neo-tree",
					"toggleterm",
				},
			}, args.buf)
		end,
	},
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
