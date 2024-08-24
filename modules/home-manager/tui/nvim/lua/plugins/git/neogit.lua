return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = function()
		return {}
	end,
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
