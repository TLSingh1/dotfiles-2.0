-- lua/modules/ui/colorizer.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-colorizer.lua",
	config = function()
		require("colorizer").setup()
	end,
})
