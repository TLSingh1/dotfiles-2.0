-- lua/modules/coding/typescript-tools.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "typescript-tools.nvim",
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	config = function()
		require("typescript-tools").setup({})

		-- Force LSP to start for the current buffer if it matches the filetypes
		local current_ft = vim.bo.filetype
		if vim.tbl_contains({ "javascript", "javascriptreact", "typescript", "typescriptreact" }, current_ft) then
			vim.schedule(function()
				vim.print("typescript tools loaded")
				vim.cmd("LspStart")
			end)
		end
	end,
})
