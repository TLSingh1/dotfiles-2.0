local conditions = require("heirline.conditions")

local StatusLine = require("plugins.ui.heirline.status-line")

return {
	"rebelot/heirline.nvim",
	event = "UIEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- if you want to use icons in the statusline
	},
	config = function()
		require("heirline").setup({
			statusline = StatusLine,
			-- winbar = WinBar,
			-- statuscolumn = StatusColumn,
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
	end,
}
