-- lua/modules/ui/dressing.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "dressing.nvim",
	event = "VimEnter",
	config = function()
		require("dressing").setup({})
	end,
})
