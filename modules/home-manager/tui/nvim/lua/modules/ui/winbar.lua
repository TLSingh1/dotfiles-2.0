-- lua/modules/ui/winbar.lua
local module_manager = require("core.module_manager")
local devicons = require("nvim-web-devicons")
local fn = vim.fn
local diagnostic = vim.diagnostic
local api = vim.api

local function get_path_components()
	local path = fn.expand("%:p:h")
	local components = {}
	local cwd = fn.getcwd()

	while path ~= cwd do
		if fn.isdirectory(path .. "/.git") == 1 then
			break
		end
		table.insert(components, 1, fn.fnamemodify(path, ":t"))
		path = fn.fnamemodify(path, ":h")
	end

	return components
end

local function lsp()
	local count = {}
	local levels = {
		errors = diagnostic.severity.ERROR,
		warnings = diagnostic.severity.WARN,
		info = diagnostic.severity.INFO,
		hints = diagnostic.severity.HINT,
	}

	for k, level in pairs(levels) do
		count[k] = #diagnostic.get(0, { severity = level })
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#WinBarDiagnosticError#󰅚 " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#WinBarDiagnosticWarn#󰀦 " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#WinBarDiagnosticHint#󰌵 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#WinBarDiagnosticInfo#󰋼 " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#WinBarComment#"
end

local function set_winbar_highlights()
	-- Get the comment highlight
	local comment_hl = api.nvim_get_hl(0, { name = "Comment" })

	local highlights = {
		WinBarComment = { fg = comment_hl.fg, bg = 0 },
		WinBarPath = { link = "WinBarComment" },
		WinBarIcon = { bg = 0 },
		WinBarFilename = { bg = 0, bold = true },
	}

	for name, val in pairs(highlights) do
		api.nvim_set_hl(0, name, val)
	end

	-- Set winbar-specific diagnostic highlights based on the predefined ones
	local diagnostic_highlights = {
		WinBarDiagnosticError = "DiagnosticError",
		WinBarDiagnosticWarn = "DiagnosticWarn",
		WinBarDiagnosticHint = "DiagnosticHint",
		WinBarDiagnosticInfo = "DiagnosticInfo",
	}

	for winbar_hl, base_hl in pairs(diagnostic_highlights) do
		local hl = api.nvim_get_hl(0, { name = base_hl })
		hl.bg = 0 -- Set background to black (0 is usually black)
		api.nvim_set_hl(0, winbar_hl, {
			fg = hl.fg,
			bg = hl.bg,
			bold = hl.bold,
			italic = hl.italic,
			underline = hl.underline,
		})
	end
end

local function build_winbar()
	local filename = fn.expand("%:t")
	local file_icon, icon_hl = devicons.get_icon(filename, fn.expand("%:e"), { default = true })
	local path_components = get_path_components()

	set_winbar_highlights()

	-- Create a winbar-specific highlight for the file icon
	local icon_hl_props = api.nvim_get_hl(0, { name = icon_hl })
	api.nvim_set_hl(0, "WinBarFileIcon", { fg = icon_hl_props.fg, bg = 0 })

	local winbar = "%#WinBarComment#"
	for _, component in ipairs(path_components) do
		winbar = winbar .. component .. "  "
	end

	winbar = winbar .. "%#WinBarFileIcon#" .. file_icon .. " %#WinBarFilename#" .. filename
	winbar = winbar .. lsp()

	return winbar
end

module_manager.use_custom({
	name = "custom_winbar",
	config = function()
		vim.o.winbar = "%{%v:lua.require'modules.ui.winbar'.build_winbar()%}"
	end,
})

return {
	build_winbar = build_winbar,
}
