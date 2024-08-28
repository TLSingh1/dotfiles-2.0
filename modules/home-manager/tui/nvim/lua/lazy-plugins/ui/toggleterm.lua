return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<A-;>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
	},
	opts = {
		open_mapping = "<A-;>",
		direction = "float",
		shell = "fish",
		float_opts = {
			border = "curved",
		},
		highlights = {
			FloatBorder = {
				guifg = "#011826",
				guibg = "#011826",
			},
		},
	},
}
