return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	cmd = { "AvanteAsk" },
	build = "make",
	config = function()
		require("avante").setup({})
	end,
}
