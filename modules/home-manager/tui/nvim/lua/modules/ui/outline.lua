-- lua/modules/ui/outline.lua
local module_manager = require("core.module_manager")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

module_manager.use_custom({
	name = "custom_outline",
	config = function()
		local outline_popup = Popup({
			enter = true,
			focusable = true,
			border = {
				style = "rounded",
			},
			position = "50%",
			size = {
				width = "80%",
				height = "60%",
			},
		})

		-- Close the popup when Escape is pressed
		outline_popup:map("n", "<Esc>", function()
			outline_popup:unmount()
		end, { noremap = true })

		-- Function to open the outline popup
		local function open_outline()
			outline_popup:mount()
			outline_popup:set_text("Symbol Outline") -- Placeholder text
		end

		-- Create a user command to open the outline
		vim.api.nvim_create_user_command("OpenOutline", open_outline, {})
	end,
})
