-- lua/modules/coding/typescript-tools.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "typescript-tools.nvim",
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	config = function()
		require("typescript-tools").setup({})
	end,
})
