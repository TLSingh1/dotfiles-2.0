-- ./lua/modules/ui/peek.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "peek.nvim",
	ft = "markdown",
	config = function()
		require("peek").setup({})
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
})
