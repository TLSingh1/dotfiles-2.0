-- lua/modules/ui/statuscolumn.lua
local module_manager = require("core.module_manager")

module_manager.use_custom({
	name = "custom_statuscolumn",
	config = function()
		function StatusColumn()
			return table.concat({
				"hello",
			})
		end

		vim.o.statuscolumn = "%!v:lua.StatusColumn()"
	end,
})
