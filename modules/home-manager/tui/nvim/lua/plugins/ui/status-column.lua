-- lua/plugins/ui/custom-statuscolumn.lua

-- Define the module outside of the lazy.nvim spec
local M = {}

function M.custom_statuscolumn()
	return "Hi"
end

-- You can add more functions or logic here as needed

-- Now define the lazy.nvim spec, referencing the module above
return {
	"custom-statuscolumn",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.statuscolumn = '%!v:lua.require("plugins.ui.custom-statuscolumn").custom_statuscolumn()'
	end,
}
