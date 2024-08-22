require("toggleterm").setup({
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
})
