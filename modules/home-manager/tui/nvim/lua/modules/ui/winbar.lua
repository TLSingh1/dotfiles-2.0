-- lua/modules/ui/winbar.lua
local module_manager = require("core.module_manager")

module_manager.use_custom({
	name = "custom_winbar",
	config = function()
		vim.o.winbar = "hello"
	end,
})
