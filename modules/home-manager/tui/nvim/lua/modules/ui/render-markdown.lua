-- lua/modules/ui/render-markdown.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "render-markdown.nvim",
	ft = {
		"markdown",
		"Avante",
		"AvanteAsk",
	}, -- Lazy load on markdown filetype
	config = function()
		require("render-markdown").setup({
			heading = {
				border = true,
				icons = { "", "", "", "", "", "" },
				-- width = "block",
				-- left_pad = 0,
				-- right_pad = 4,
			},
			code = {
				enabled = true,
				style = "full",
				position = "right",
				language_pad = 0,
				width = "block",
				left_pad = 0,
				right_pad = 4,
				min_width = 0,
				border = "thick",
			},
			bullet = {
				enabled = true,
				-- Replaces '-'|'+'|'*' of 'list_item'
				-- How deeply nested the list is determines the 'level'
				-- The 'level' is used to index into the array using a cycle
				-- If the item is a 'checkbox' a conceal is used to hide the bullet instead
				icons = { "•", "○", "◆", "◇" },
				-- Padding to add to the left of bullet point
				left_pad = 0,
				-- Padding to add to the right of bullet point
				right_pad = 0,
				-- Highlight for the bullet icon
				highlight = "RenderMarkdownBullet",
			},
		})
	end,
})
