local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-treesitter",
	config = function()
		vim.opt.runtimepath:append("/nix/store/8iwi6pzi9690yl1l0dv3r497hml7zylf-vimplugin-nvim-treesitter-2024-08-04")

		local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
		vim.opt.runtimepath:prepend(parser_install_dir)

		require("nvim-treesitter.configs").setup({
			parser_install_dir = parser_install_dir,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ensure_installed = {},
			sync_install = false,
			auto_install = false,
			ignore_install = {},
		})
	end,
})
