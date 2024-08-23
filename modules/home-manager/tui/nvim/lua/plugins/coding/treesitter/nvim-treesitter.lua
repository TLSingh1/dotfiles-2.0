return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			-- Set custom parser install directory
			vim.g.ts_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
			vim.fn.mkdir(vim.g.ts_install_dir, "p")
			vim.opt.runtimepath:append(vim.g.ts_install_dir)

			require("nvim-treesitter.configs").setup({
				parser_install_dir = vim.g.ts_install_dir,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				ensure_installed = {}, -- We don't need to install anything, as we're using pre-compiled parsers
				sync_install = false,
				auto_install = false,
				ignore_install = {},
			})

			-- Manually load the Svelte parser
			local svelte_parser = vim.g.ts_install_dir .. "/svelte.so"
			if not vim.loop.fs_stat(svelte_parser) then
				vim.fn.system({
					"cp",
					"${pkgs.vimPlugins.nvim-treesitter-parsers.svelte}/parser/svelte.so",
					svelte_parser,
				})
			end
			vim.treesitter.language.add("svelte", { path = svelte_parser })

			-- Force Treesitter to load parsers
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.svelte" },
				callback = function()
					vim.cmd("TSEnable highlight")
				end,
			})
		end,
	},
}
