return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	event = {
		"BufReadPre /home/tai/Brain/*.md",
		"BufNewFile /home/tai/Brain/*.md",
	},
	opts = {
		workspaces = {
			{
				name = "brain",
				path = "~/Brain",
			},
		},
	},
}
