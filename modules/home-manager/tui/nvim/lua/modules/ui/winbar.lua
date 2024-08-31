-- lua/modules/ui/winbar.lua
local module_manager = require("core.module_manager")

module_manager.use_custom({
	name = "custom_statusline",
	config = function()
		vim.api.nvim_create_autocmd("VimEnter", {
			pattern = "*",
			callback = function()
				print("hello custom winbar")
			end,
		})
	end,
})
