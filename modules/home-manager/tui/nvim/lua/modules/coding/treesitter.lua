local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-treesitter",
	config = function()
		-- Set custom parser install directory
		local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
		vim.fn.mkdir(parser_install_dir, "p")
		vim.opt.runtimepath:append(parser_install_dir)

		require("nvim-treesitter.configs").setup({
			parser_install_dir = parser_install_dir, -- Set the custom parser directory
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ensure_installed = {}, -- This will use all available parsers
			sync_install = false,
			auto_install = false,
			ignore_install = {},
			textObjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
			},
		})
	end,
})
