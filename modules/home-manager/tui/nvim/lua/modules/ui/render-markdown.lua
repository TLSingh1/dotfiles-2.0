-- lua/modules/ui/render-markdown.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "render-markdown.nvim",
	ft = "markdown", -- Lazy load on markdown filetype
	config = function()
		require("render-markdown").setup({})
	end,
})
