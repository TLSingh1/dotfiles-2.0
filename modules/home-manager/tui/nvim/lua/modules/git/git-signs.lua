-- lua/modules/git/gitsigns.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "gitsigns.nvim",
	event = { "InsertEnter", "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({})
	end,
})
