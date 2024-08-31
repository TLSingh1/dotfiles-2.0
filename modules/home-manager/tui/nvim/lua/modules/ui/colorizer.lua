-- lua/modules/ui/colorizer.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "colorizer-nvim",
	config = function()
		local ok, colorizer = pcall(require, "colorizer")
		if ok then
			colorizer.setup()
		end
	end,
})
