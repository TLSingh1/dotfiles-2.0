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
end

local function numbers()
	-- check if the current line is a wrapped line
	if vim.v.virtnum > 0 then
		return "  "
	else
		return "%{v:relnum ? v:relnum : v:lnum}  "
	end
end

local function border()
	local relnum = vim.v.relnum
	local index = math.abs(relnum) + 1
	if index > #colors then
		index = #colors
	end

	-- Use the special highlight for the current line
	if vim.v.lnum == vim.fn.line(".") then
		return "%#StatusBorderCurrent#▏%* "
	else
		return string.format("%%#StatusBorder_%d#▏%%* ", index)
	end
end

function StatusColumn()
	local bufnr = vim.api.nvim_get_current_buf()
	if conditions.buffer_matches({ filetype = disabled_filetypes }, bufnr) then
		return ""
	end

	return table.concat({
		"%=",
		numbers(),
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
