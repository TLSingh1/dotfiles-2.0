require("toggleterm").setup({
	open_mapping = "<A-;>",
	direction = "float",
	shell = "fish",
	float_opts = {
		border = "curved",
	},
	highlights = {
		FloatBorder = {
			guifg = "#1E1E2F",
			guibg = "#1E1E2F",
		},
	},
})
