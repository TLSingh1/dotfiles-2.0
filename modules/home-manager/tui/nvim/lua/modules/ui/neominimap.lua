-- ./lua/modules/ui/neominimap.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "neominimap.nvim",
	config = function()
		vim.opt.wrap = false
		vim.opt.sidescrolloff = 36

		-- local neominimap = require("neominimap")
		-- neominimap.setup({})

		vim.g.neominimap = {
			auto_enable = true,
		}
	end,
})
