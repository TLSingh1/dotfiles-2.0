local module_manager = require("core.module_manager")

module_manager.use({
	name = "helpview.nvim",
	config = function()
		require("helpview").setup({})
	end,
})
