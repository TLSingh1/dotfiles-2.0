local module_manager = require("core.module_manager")

module_manager.use({
	name = "no-neck-pain.nvim",
	config = function()
		require("no-neck-pain").setup({
			buffers = {
				scratchPad = {
					enabled = true,
					location = "~/Documents/",
				},
				bo = {
					filetype = "md",
				},
				wo = {
					fillchars = "eob: ",
				},
			},
		})
	end,
})
