-- lua/modules/coding/ts-autotag.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Override individual filetype configs
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		})
	end,
})
