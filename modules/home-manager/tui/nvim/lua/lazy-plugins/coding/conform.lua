return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "alejandra" },
			markdown = { "prettierd", "prettier" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--prose-wrap", "always" },
			},
		},
	},
}
