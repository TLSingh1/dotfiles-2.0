return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	opts = {
		workspaces = {
			{
				name = "brain",
				path = "~/Brain",
			},
		},
		log_level = vim.log.levels.INFO,
		completion = {
			nvim_cmp = true,
			min_characters = 2,
		},
		templates = {
			subdir = "'000 Templates'",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		picker = {
			name = "telescope.nvim",
		},
		ui = {
			enable = false,
		},
	},
}
