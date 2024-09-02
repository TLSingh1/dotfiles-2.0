local module_manager = require("core.module_manager")

module_manager.use({
	name = "diagram.nvim",
	config = function()
		require("diagram").setup({
			integrations = {
				require("diagram.integrations.markdown"),
				require("diagram.integrations.neorg"),
			},
			renderer_options = {
				mermaid = {
					background = nil, -- nil | "transparent" | "white" | "#hex"
					theme = "forest", -- nil | "default" | "dark" | "forest" | "neutral"
					scale = 1, -- nil | 1 (default) | 2  | 3 | ...
				},
				plantuml = {
					charset = "utf-8",
				},
				d2 = {
					theme_id = 1,
					dark_theme_id = nil,
					scale = nil,
					layout = nil,
					sketch = nil,
				},
			},
		})
	end,
})
