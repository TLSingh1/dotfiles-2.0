-- lua/modules/ai/copilot.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "copilot.vim",
	-- Since Copilot is a general-purpose AI assistant, you might want to load it for all file types
	-- Alternatively, you can specify events or commands to lazy-load it
	-- For example, to load on InsertEnter:
	-- event = "InsertEnter",

	-- If you want to add any specific configuration for Copilot, you can do so in the config function:
	-- config = function()
	--     -- Add any Copilot-specific settings here
	--     -- For example:
	--     -- vim.g.copilot_no_tab_map = true
	--     -- vim.g.copilot_assume_mapped = true
	--     -- vim.g.copilot_tab_fallback = ""
	-- end,
})
