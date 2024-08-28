return {
	"MeanderingProgrammer/render-markdown.nvim",
	config = function()
		require("render-markdown").setup({
			enabled = true,
			file_types = { "markdown", "quatro" },
			render_modes = { "n", "c" },
			debounce = 50,
			win_options = {
				conceallevel = {
					default = vim.api.nvim_get_option_value("conceallevel", {}),
					rendered = 3,
				},
				concealcursor = {
					default = vim.api.nvim_get_option_value("concealcursor", {}),
					rendered = "",
				},
			},
			overrides = {
				buftype = {
					nofile = {
						sign = { enabled = false },
						-- code = { left_pad = 0, right_pad = 0 },
					},
				},
				filetype = {},
			},
		})
	end,
}
