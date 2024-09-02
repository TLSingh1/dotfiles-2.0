-- lua/modules/git/neogit.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "neogit",
	cmd = "Neogit",
	config = function()
		require("neogit").setup({
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
	end,
})
