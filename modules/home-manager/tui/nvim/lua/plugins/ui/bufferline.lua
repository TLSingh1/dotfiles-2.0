require("bufferline").setup({
	options = {
		themable = true,
		numbers = "none",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		color_icons = true,
		-- indicator = {
		-- 	icon = "",
		-- 	style = "icon",
		-- },
		-- buffer_close_icon = "",
		buffer_close_icon = '',
		modified_icon = "●",
		close_icon = "",
		-- close_icon = '',
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 20,
		diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			if level == "error" then
				return " " .. count
			elseif level == "warning" then
				return " " .. count
			elseif level == "info" then
				return " " .. count
			elseif level == "hint" then
				return "💡" .. count
			else
				return ""
			end
		end,
		offsets = {
			{
				filetype = "neo-tree",
				text = "",
				text_align = "center",
				padding = 1,
				highlight = "ActiveWindow",
				separator = false,
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
	},
})

