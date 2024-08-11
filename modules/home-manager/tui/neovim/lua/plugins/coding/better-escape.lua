require("better_escape").setup({
	mappings = {
		i = {
			[" "] = {
				["<tab>"] = function()
					-- Defer execution to avoid side-effects
					vim.defer_fn(function()
						-- set undo point
						vim.o.ul = vim.o.ul
						require("luasnip").expand_or_jump()
					end, 1)
				end,
			},
		},
		v = {
			j = {
				k = false,
			},
		},
	},
})
