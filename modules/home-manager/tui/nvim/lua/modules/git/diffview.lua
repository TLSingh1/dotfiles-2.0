-- lua/modules/git/diffview.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "diffview.nvim",
	config = function()
		require("diffview").setup({})
	end,
})
