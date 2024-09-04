local module_manager = require("core.module_manager")

local conditions = require("heirline.conditions")
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

local function get_file_status()
	if vim.bo.modified then
		return " %#WinBarModified#󰷈 %#WinBarComment#"
	elseif not vim.bo.modifiable or vim.bo.readonly then
		return " %#WinBarReadOnly#󰌾 %#WinBarComment#"
	end
	return ""
end

local function get_line_col_info()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local total_lines = vim.fn.line("$")
	return string.format("%d/%d:%d", line, total_lines, col)
end

local function vi_mode()
	local mode_names = { -- change the strings if you like it vvvvverbose!
		n = "N",
		no = "N?",
		nov = "N?",
		noV = "N?",
		["no\22"] = "N?",
		niI = "Ni",
		niR = "Nr",
		niV = "Nv",
		nt = "Nt",
		v = "V",
		vs = "Vs",
		V = "V_",
		Vs = "Vs",
		["\22"] = "^V",
		["\22s"] = "^V",
		s = "S",
		S = "S_",
		["\19"] = "^S",
		i = "I",
		ic = "Ic",
		ix = "Ix",
		R = "R",
		Rc = "Rc",
		Rx = "Rx",
		Rv = "Rv",
		Rvc = "Rv",
		Rvx = "Rv",
		c = "C",
		cv = "Ex",
		r = "...",
		rm = "M",
		["r?"] = "?",
		["!"] = "!",
		t = "T",
	}
	local mode_colors = {
		n = "#EBA0AD",
		i = "#f11a9b",
		v = "cyan",
		V = "cyan",
		["\22"] = "cyan",
		c = "orange",
		s = "purple",
		S = "purple",
		["\19"] = "purple",
		R = "orange",
		r = "orange",
		["!"] = "red",
		t = "#94E395",
	}

	local mode = vim.fn.mode(1)
	local mode_name = mode_names[mode] or mode
	local mode_color = mode_colors[mode] or "white"

	local bg_color = conditions.is_active() and "#233B48" or "#000000"

	vim.api.nvim_set_hl(0, "WinBarViMode", { fg = mode_color, bg = bg_color, bold = true })
	return string.format("%%#WinBarViMode# %s%%#WinBarViMode#", mode_name)
end

local function set_winbar_highlights()
	local diagnostic_highlights = {
		WinBarDiagnosticError = "DiagnosticError",
		WinBarDiagnosticWarn = "DiagnosticWarn",
		WinBarDiagnosticHint = "DiagnosticHint",
		WinBarDiagnosticInfo = "DiagnosticInfo",
	}

	local bg_hl = conditions.is_active() and "#011826" or "#000000"

	for winbar_hl, base_hl in pairs(diagnostic_highlights) do
		local hl = api.nvim_get_hl(0, { name = base_hl })
		api.nvim_set_hl(0, winbar_hl, {
			fg = hl.fg,
			bg = bg_hl,
			bold = hl.bold,
			italic = hl.italic,
			underline = hl.underline,
		})
	end

	api.nvim_set_hl(0, "WinBarModified", { fg = "#F5A97F", bg = bg_hl, bold = true })
	api.nvim_set_hl(0, "WinBarReadOnly", { fg = "#C6A0F6", bg = bg_hl, bold = true })
end

local function build_winbar()
	local ok, result = pcall(function()
		local buftype = vim.bo.buftype
		if buftype == "help" or buftype == "nofile" or buftype == "prompt" then
			return "" -- return empty string for unsupported buffer types
		end

		local filename = fn.expand("%:t")
		if filename == "" then
			return "" -- return empty string for empty filenames
		end

		local file_icon, icon_hl = devicons.get_icon(filename, fn.expand("%:e"), { default = true })
		local path_components = get_path_components()

		set_winbar_highlights()

		-- i know this is bad setting highlights outside of dedicated function. sue me
		local icon_hl_props = api.nvim_get_hl(0, { name = icon_hl })
		local icon_bg = conditions.is_active() and "#011826" or "#000000"
		api.nvim_set_hl(0, "WinBarFileIcon", { fg = icon_hl_props.fg, bg = icon_bg })

		local filename_bg = conditions.is_active() and "#011826" or "#000000"
		api.nvim_set_hl(0, "WinBarFilename", { fg = "#F5E0DD", bg = filename_bg, bold = true })

		local winbar = "%#WinBarComment#"
		for _, component in ipairs(path_components) do
			winbar = winbar .. component .. "  "
		end

		local line_col_bg = conditions.is_active() and "#233B48" or "#000000"
		api.nvim_set_hl(0, "WinBarLineCol", { fg = "#E2F0F8", bg = line_col_bg, bold = true })

		local surround_fg = conditions.is_active() and "#233B48" or "#000000"
		local surround_bg = conditions.is_active() and "#011826" or "#000000"
		api.nvim_set_hl(0, "WinBarSurround", { fg = surround_fg, bg = surround_bg })

		if conditions.is_active() then
			winbar = winbar .. "%#WinBarFileIcon#" .. file_icon .. " %#WinBarFilename#" .. filename
			winbar = winbar .. get_file_status()
			winbar = winbar .. lsp()
			winbar = winbar
				.. "%="
				.. "%#WinBarSurround#"
				.. "%#WinBarLineCol#"
				.. get_line_col_info()
				.. "%#WinBarSurround#"
				.. " "
				.. "%#WinBarSurround#"
				.. vi_mode()
				.. "%#WinBarSurround#"
		else
			winbar = winbar .. "%#WinBarFileIcon#" .. file_icon .. " %#WinBarFilename#" .. filename
			winbar = winbar .. get_file_status()
			winbar = winbar .. lsp()
			winbar = winbar
				.. "%="
				.. " "
				.. "%#WinBarLineCol#"
				.. get_line_col_info()
				.. " "
				.. " "
				.. " "
				.. vi_mode()
				.. " "
		end

		return winbar
	end)

	if not ok then
		vim.nvim_notify("Error in winbar: " .. tostring(result), vim.log.levels.ERROR)
		return "" -- return empty string on error
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
