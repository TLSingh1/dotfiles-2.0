-- lua/modules/coding/nvim-surround.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-surround",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-surround").setup({})
	end,
})
