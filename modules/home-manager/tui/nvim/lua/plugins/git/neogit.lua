return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
	},
	opts = {
		signs = {
			item = { "", " " },
			section = { "", " " },
		},
		integrations = {
			telescope = true,
			diffview = true,
		},
		mappings = {
			status = {
				["l"] = "Toggle",
				["S"] = "StageAll",
			},
		},
	},
}
