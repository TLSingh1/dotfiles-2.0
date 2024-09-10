-- ./lua/modules/ui/aerial.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "aerial.nvim",
	config = function()
		require("aerial").setup({})
	end,
})
