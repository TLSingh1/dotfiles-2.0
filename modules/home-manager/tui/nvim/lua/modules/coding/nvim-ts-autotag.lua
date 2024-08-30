-- lua/modules/coding/nvim-ts-autotag.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-ts-autotag",
	event = { "InsertEnter", "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-ts-autotag").setup({})
	end,
})
