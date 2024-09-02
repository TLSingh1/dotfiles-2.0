-- lua/modules/ui/statuscolumn.lua
local module_manager = require("core.module_manager")
local conditions = require("heirline.conditions")

local disabled_filetypes = {
	"NvimTree",
	"Avante",
	"AvanteInput",
}

-- Define gradient colors
local colors = {
	"#f2c9ff",
	"#e5b8f7",
	"#d8a8ef",
	"#cc98e7",
	"#bf88df",
	"#b378d7",
	"#a668cf",
	"#9a58c7",
	"#8d48bf",
	"#8138b7",
	"#753BA4",
	"#643F8A",
	"#554373",
	"#45475B",
}

-- Set up gradient highlight groups
local function setup_gradient_highlights()
	for i, color in ipairs(colors) do
		vim.api.nvim_set_hl(0, "StatusBorder_" .. i, { fg = color })
	end
	-- Set up a special highlight for the current line's border
	vim.api.nvim_set_hl(0, "StatusBorderCurrent", { fg = colors[1], bg = "#0B2534" })
	vim.api.nvim_set_hl(0, "StatusColumnCurrentLine", { bg = "#0B2534" })
end

local function get_signs(buf, lnum)
	local signs = {}
	local placed_signs = vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs
	for _, sign in ipairs(placed_signs) do
		local defined_sign = vim.fn.sign_getdefined(sign.name)[1]
		if defined_sign then
			local ret = {
				name = defined_sign.name,
				text = defined_sign.text,
				texthl = defined_sign.texthl,
				priority = sign.priority,
			}
			table.insert(signs, ret)
		end
	end

	local extmarks = vim.api.nvim_buf_get_extmarks(
		buf,
		-1,
		{ lnum - 1, 0 },
		{ lnum - 1, -1 },
		{ details = true, type = "sign" }
	)
	for _, extmark in pairs(extmarks) do
		signs[#signs + 1] = {
			name = extmark[4].sign_hl_group or "",
			text = extmark[4].sign_text,
			texthl = extmark[4].sign_hl_group,
			priority = extmark[4].priority,
		}
	end

	table.sort(signs, function(a, b)
		return (a.priority or 0) < (b.priority or 0)
	end)

	return signs
end

local function get_mark(bufnr, lnum)
	local marks = vim.fn.getmarklist(bufnr)
	vim.list_extend(marks, vim.fn.getmarklist())
	for _, mark in ipairs(marks) do
		if mark.pos[1] == bufnr and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
			return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
		end
	end
end

local function icon(sign)
	if not sign then
		return " "
	end
	local text = vim.fn.strcharpart(sign.text or "", 0, 1)
	if sign.texthl then
		if vim.v.lnum == vim.fn.line(".") then
			return string.format("%%#StatusColumnCurrentLine#%%#%s#%%X%s%%*", sign.texthl, text)
		else
			return string.format("%%#%s#%s%%*", sign.texthl, text)
		end
	else
		return text
	end
end

local function get_severity(sign_name)
	if sign_name:match("Error") then
		return 1
	elseif sign_name:match("Warn") then
		return 2
	elseif sign_name:match("Info") then
		return 3
	elseif sign_name:match("Hint") then
		return 4
	end
	return 5 -- non-diagnostic signs
end

local function signs()
	local bufnr = vim.api.nvim_get_current_buf()
	local signs = get_signs(bufnr, vim.v.lnum)
	local diagnostic_sign, git_sign

	local highest_severity = 5
	for _, s in ipairs(signs) do
		if s.name and s.name:find("GitSign") then
			git_sign = s
		else
			local severity = get_severity(s.name)
			if severity < highest_severity then
				highest_severity = severity
				diagnostic_sign = s
			end
		end
	end

	local mark = get_mark(bufnr, vim.v.lnum)
	local final_sign = mark or diagnostic_sign or git_sign
	return icon(final_sign)
end

local function folds()
	local foldlevel = vim.fn.foldlevel(vim.v.lnum)
	local foldlevel_before = vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and vim.v.lnum - 1 or 1)
	local foldlevel_after =
		vim.fn.foldlevel((vim.v.lnum + 1) <= vim.fn.line("$") and (vim.v.lnum + 1) or vim.fn.line("$"))

	local foldclosed = vim.fn.foldclosed(vim.v.lnum)

	local fold_char = " "
	if foldlevel == 0 then
		fold_char = " "
	elseif foldclosed ~= -1 and foldclosed == vim.v.lnum then
		fold_char = "▶"
	elseif foldlevel > foldlevel_before then
		fold_char = "▽"
	elseif foldlevel > foldlevel_after then
		fold_char = "╰"
	else
		fold_char = "│"
	end

	return fold_char
end

local function numbers()
	if vim.v.virtnum > 0 then
		return string.rep(" ", 3)
	else
		local num = vim.v.relnum ~= 0 and vim.v.relnum or vim.v.lnum
		return string.format("%3d", num)
	end
end

local function border()
	local relnum = vim.v.relnum
	local index = math.abs(relnum) + 1
	if index > #colors then
		index = #colors
	end

	if vim.v.lnum == vim.fn.line(".") then
		return "%#StatusBorderCurrent#▏ %*"
	else
		return string.format("%%#StatusBorder_%d#▏ %%*", index)
	end
end

function StatusColumn()
	local bufnr = vim.api.nvim_get_current_buf()
	if conditions.buffer_matches({ filetype = disabled_filetypes }, bufnr) then
		return ""
	end

	return table.concat({
		"%=",
		signs(),
		"  ",
		folds(),
		-- "  ",
		numbers(),
		"  ",
		border(),
	})
end

module_manager.use_custom({
	name = "custom_statuscolumn",
	config = function()
		setup_gradient_highlights()
		vim.o.statuscolumn = "%!v:lua.StatusColumn()"
	end,
})
