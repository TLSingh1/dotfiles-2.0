require("colorful-winsep").setup({
	-- highlight for Window separator
	hi = {
		bg = "#000000",
		fg = "#1E1E2F",
	},
	no_exec_files = { "TelescopePrompt", "neo-tree" },
	-- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
	symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
	-- #70: https://github.com/nvim-zh/colorful-winsep.nvim/discussions/70
	only_line_seq = true,
	-- Smooth moving switch
	smooth = true,
	exponential_smoothing = true,
	anchor = {
		left = { height = 1, x = -1, y = -1 },
		right = { height = 1, x = -1, y = 0 },
		up = { width = 0, x = -1, y = 0 },
		bottom = { width = 0, x = 1, y = 0 },
	},
})
