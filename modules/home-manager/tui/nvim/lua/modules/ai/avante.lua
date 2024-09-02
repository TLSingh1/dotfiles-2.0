-- lua/modules/ai/avante.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "avante.nvim",
	cmd = "AvanteAsk",
	config = function()
		require("avante").setup({})
	end,
})