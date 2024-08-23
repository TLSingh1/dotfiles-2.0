return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
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
