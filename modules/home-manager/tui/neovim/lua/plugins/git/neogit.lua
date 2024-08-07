local neogit = require("neogit")
neogit.setup({
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
})
