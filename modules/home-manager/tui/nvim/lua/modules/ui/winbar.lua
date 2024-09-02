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
	local comment_hl = api.nvim_get_hl(0, { name = "Comment" })

	local highlights = {
		WinBarComment = { fg = comment_hl.fg, bg = "#000000" },
		WinBarPath = { fg = "#1affff", bg = "#ff4444" },
		WinBarIcon = { bg = "#000000" },
		WinBarFilename = { bg = "#000000", bold = true },
	}

	for name, val in pairs(highlights) do
		api.nvim_set_hl(0, name, val)
	end

	local diagnostic_highlights = {
		WinBarDiagnosticError = "DiagnosticError",
		WinBarDiagnosticWarn = "DiagnosticWarn",
		WinBarDiagnosticHint = "DiagnosticHint",
		WinBarDiagnosticInfo = "DiagnosticInfo",
	}

	for winbar_hl, base_hl in pairs(diagnostic_highlights) do
		local hl = api.nvim_get_hl(0, { name = base_hl })
		hl.bg = nil
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
	local ok, result = pcall(function()
		local buftype = vim.bo.buftype
		if buftype == "help" or buftype == "nofile" or buftype == "prompt" then
			return "" -- Return empty string for unsupported buffer types
		end

		local filename = fn.expand("%:t")
		if filename == "" then
			return "" -- Return empty string for empty filenames
		end

		local file_icon, icon_hl = devicons.get_icon(filename, fn.expand("%:e"), { default = true })
		local path_components = get_path_components()

		set_winbar_highlights()

		local icon_hl_props = api.nvim_get_hl(0, { name = icon_hl })
		api.nvim_set_hl(0, "WinBarFileIcon", { fg = icon_hl_props.fg, bg = "#000000" })

		local winbar = "%#WinBarComment#"
		for _, component in ipairs(path_components) do
			winbar = winbar .. component .. "  "
		end

		winbar = winbar .. "%#WinBarFileIcon#" .. file_icon .. " %#WinBarFilename#" .. filename
		winbar = winbar .. lsp()

		return winbar
	end)

	if not ok then
		vim.notify("Error in winbar: " .. tostring(result), vim.log.levels.ERROR)
		return "" -- Return empty string on error
	end

	return result
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
