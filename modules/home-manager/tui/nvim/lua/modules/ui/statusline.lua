-- lua/modules/ui/statusline.lua
local module_manager = require("core.module_manager")
local api = vim.api
local diagnostic = vim.diagnostic

local function is_git_repo()
	local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
	return git_dir and #git_dir > 0
end

local function create_git_component()
	if not is_git_repo() then
		return ""
	end

	local status_dict = vim.b.gitsigns_status_dict
	if not status_dict then
		return ""
	end

	local components = {}

	local function add_count(symbol, count, highlight)
		if count and count > 0 then
			table.insert(components, string.format("%%#%s#%s %d ", highlight, symbol, count))
		end
	end

	add_count(" ", status_dict.added, "StatusLineGitAdded")
	add_count(" ", status_dict.removed, "StatusLineGitRemoved")
	add_count("󰝤 ", status_dict.changed, "StatusLineGitChanged")

	if status_dict.head then
		table.insert(components, string.format("%%#StatusLineGitBranch#   %s ", status_dict.head))
	end

	return table.concat(components)
end

local function get_buffer_list()
	local buffers = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
			table.insert(buffers, bufnr)
		end
	end
	return buffers
end

local function get_diagnostics(bufnr)
	local diagnostics = {
		errors = #diagnostic.get(bufnr, { severity = diagnostic.severity.ERROR }),
		warnings = #diagnostic.get(bufnr, { severity = diagnostic.severity.WARN }),
		info = #diagnostic.get(bufnr, { severity = diagnostic.severity.INFO }),
		hints = #diagnostic.get(bufnr, { severity = diagnostic.severity.HINT }),
	}
	return diagnostics
end

local function get_buffer_info(bufnr)
	local name = api.nvim_buf_get_name(bufnr)
	local filename = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
	local is_current = bufnr == api.nvim_get_current_buf()
	local is_visible = false

	for _, winid in ipairs(api.nvim_list_wins()) do
		if api.nvim_win_get_buf(winid) == bufnr then
			is_visible = true
			break
		end
	end

	return {
		bufnr = bufnr,
		filename = filename,
		is_current = is_current,
		is_visible = is_visible,
		diagnostics = get_diagnostics(bufnr),
	}
end

local function create_buffer_component(info)
	local diag_str = ""
	if info.diagnostics.errors > 0 then
		diag_str = diag_str .. string.format(" %%#StatusLineDiagError#󰅚 %d", info.diagnostics.errors)
	end
	if info.diagnostics.warnings > 0 then
		diag_str = diag_str .. string.format(" %%#StatusLineDiagWarn#󰀦 %d", info.diagnostics.warnings)
	end
	if info.diagnostics.info > 0 then
		diag_str = diag_str .. string.format(" %%#StatusLineDiagInfo#󰋼 %d", info.diagnostics.info)
	end
	if info.diagnostics.hints > 0 then
		diag_str = diag_str .. string.format(" %%#StatusLineDiagHint#󰌵 %d", info.diagnostics.hints)
	end

	return string.format("%%#StatusLineBuffer_%s#  %s %s  %%*", info.bufnr, info.filename, diag_str)
end

local function build_statusline()
	local buffers = get_buffer_list()
	local components = {}

	local comment_hl = api.nvim_get_hl(0, { name = "Comment" })
	local comment_fg = comment_hl.fg and string.format("#%06x", comment_hl.fg) or "Gray"

	for _, bufnr in ipairs(buffers) do
		local info = get_buffer_info(bufnr)
		local bg_color, fg_color, bold, italic
		if info.is_current then
			bg_color = "#233B48"
			fg_color = "#E2F0F8"
			italic = false
			bold = true
		elseif info.is_visible then
			bg_color = "#0B2534"
			fg_color = comment_fg
			italic = true
			bold = false
		else
			bg_color = "#000000"
			fg_color = comment_fg
			italic = true
			bold = false
		end

		-- Use native Neovim API to set highlights
		local diagnostic_highlights = {
			StatusLineDiagError = "DiagnosticError",
			StatusLineDiagWarn = "DiagnosticWarn",
			StatusLineDiagHint = "DiagnosticHint",
			StatusLineDiagInfo = "DiagnosticInfo",
		}

		api.nvim_set_hl(
			0,
			string.format("StatusLineBuffer_%s", bufnr),
			{ bg = bg_color, fg = fg_color, bold = bold, italic = italic }
		)
		for hl, base_hl in pairs(diagnostic_highlights) do
			local hl_props = api.nvim_get_hl(0, { name = base_hl })
			api.nvim_set_hl(0, hl, { fg = hl_props.fg, bg = bg_color })
		end

		table.insert(components, create_buffer_component(info))
	end

	api.nvim_set_hl(0, "StatusLineGitAdded", { fg = "#a6e3a2", bg = "#000000" })
	api.nvim_set_hl(0, "StatusLineGitRemoved", { fg = "#f38ba9", bg = "#000000" })
	api.nvim_set_hl(0, "StatusLineGitChanged", { fg = "#f9e2b0", bg = "#000000" })
	api.nvim_set_hl(0, "StatusLineGitBranch", { fg = "#fab388", bg = "#000000", bold = true })

	table.insert(components, "%=") -- Right align
	table.insert(components, create_git_component())

	return table.concat(components)
end

module_manager.use_custom({
	name = "custom_statusline",
	config = function()
		vim.o.statusline = "%{%v:lua.require'modules.ui.statusline'.build_statusline()%}"
	end,
})

return {
	build_statusline = build_statusline,
}
