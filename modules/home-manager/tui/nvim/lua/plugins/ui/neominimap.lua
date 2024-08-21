local minimap = require("neominimap")
minimap.setup({
	auto_enable = false,
	git = {
		enabled = false,
	},
})

-- vim.api.nvim_set_keymap("n", "<leader>m", "", {
-- 	noremap = true,
-- 	silent = true,
-- 	desc = "open minimap and focus",
-- 	callback = function()
-- 		minimap.winToggle()
-- 		minimap.toggleFocus()
-- 	end,
-- })
