-- ./lua/modules/ui/nvim-tree.lua
local module_manager = require("core.module_manager")

local function edit_or_open()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()

	if node.nodes ~= nil then
		-- expand or collapse folder
		api.node.open.edit()
	else
		-- open file
		api.node.open.edit()
		-- Close the tree if file was opened
		api.tree.close()
	end
end

local function vsplit_preview()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()

	if node.nodes ~= nil then
		api.node.open.edit()
	else
		api.node.open.vertical()
	end

	api.tree.focus()
end

local function collapse_parent()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	if not node then
		return
	end

	if node.type == "directory" and node.open then
		api.node.open.edit()
	else
		api.node.navigate.parent()
		node = api.tree.get_node_under_cursor()

		if node and node.type == "directory" and node.open then
			api.node.open.edit()
		end
	end
end

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Vsplit"))
	vim.keymap.set("n", "V", api.node.open.horizontal, opts("Vsplit"))
	vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
	vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
	vim.keymap.set("n", "h", collapse_parent, opts("Collapse Parent"))
	vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
end

local HEIGHT_RATIO = 0.5
local WIDTH_RATIO = 0.3

local config = {
	on_attach = my_on_attach,
	disable_netrw = true,
	hijack_unnamed_buffer_when_opening = true,
	view = {
		signcolumn = "yes",
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,
	},
	renderer = {
		root_folder_modifier = ":t",
		add_trailing = false,
		highlight_git = "all",
		highlight_diagnostics = "name",
		highlight_opened_files = "all",
		highlight_modified = "all",
		highlight_hidden = "all",
		highlight_bookmarks = "all",
		highlight_clipboard = "name",
		indent_markers = {
			enable = false,
			inline_arrows = true,
		},
		icons = {
			-- ... (rest of the icons configuration)
		},
	},
	update_focused_file = {
		enable = true,
		update_root = {
			enable = false,
			ignore_list = {},
		},
		exclude = false,
	},
	git = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		disable_for_dirs = {},
		timeout = 400,
		cygwin_support = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	modified = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
}

module_manager.use({
	name = "nvim-tree.lua",
	cmd = "NvimTreeToggle",
	config = function()
		require("nvim-tree").setup(config)
	end,
})

vim.api.nvim_set_keymap("n", ";", ":NvimTreeToggle <CR>", { noremap = true, silent = true })
