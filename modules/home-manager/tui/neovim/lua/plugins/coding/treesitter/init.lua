require("nvim-treesitter.configs").setup({
	-- Managed with nixos
	auto_install = false,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

require("plugins.coding.treesitter.context")
