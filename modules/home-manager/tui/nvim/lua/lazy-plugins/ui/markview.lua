return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	config = function()
		local markview = require("markview")
		local presets = require("markview.presets")

		markview.setup({
			headings = presets.headings.glow_labels,
		})

		vim.cmd("Markview enableAll")
	end,
}
