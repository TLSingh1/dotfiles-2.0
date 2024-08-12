_G.status_column_colors = {}

local function interpolate_color(color1, color2, factor)
	local r1, g1, b1 = tonumber(color1:sub(2, 3), 16), tonumber(color1:sub(4, 5), 16), tonumber(color1:sub(6, 7), 16)
	local r2, g2, b2 = tonumber(color2:sub(2, 3), 16), tonumber(color2:sub(4, 5), 16), tonumber(color2:sub(6, 7), 16)

	local r = math.floor(r1 + (r2 - r1) * factor)
	local g = math.floor(g1 + (g2 - g1) * factor)
	local b = math.floor(b1 + (b2 - b1) * factor)

	return string.format("#%02X%02X%02X", r, g, b)
end

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	color_overrides = {
		all = {
			base = "#011826",
		},
	},
	custom_highlights = function()
		local colors = {}

		for i = 0, 9 do
			colors[i + 1] = interpolate_color("#B4BEFF", "#45475B", i / 9)
		end

		_G.status_column_colors = colors

		-- setup highlight groups
		local function setup_highlights()
			for i, color in ipairs(colors) do
				vim.api.nvim_set_hl(0, "LineNr_" .. i, { fg = color })
			end
			-- set brightest line
			vim.api.nvim_set_hl(0, "LineNr_Current", { fg = colors[1], bold = true })
		end

		setup_highlights()

		return {
			WinSeparator = { fg = "#011826", bg = "#000000" },
			NeoTreeFloatBorder = { fg = "#011826", bg = "#011826" },
			NeoTreeFloatTitle = { fg = "#011826", bg = "#011826" },
			NeoTreeNormal = { bg = "#011826" },
			NeoTreeTabActive = { bg = "#0B2534" },
			NeoTreeTabSeparatorActive = { fg = "#0B2534", bg = "#0B2534" },
			NoiceCmdLine = { bg = "#000000" },
			TelescopePromptNormal = { bg = "#0B2534" },
			TelescopePromptBorder = { fg = "#0B2534", bg = "#0B2534" },
			TelescopePrompt = { fg = "#0B2534", bg = "#0B2534" },
			TelescopeBorder = { fg = "#011826", bg = "#011826" },
			TelescopeSelection = { bg = "#233B48" },
			TelescopeSelectionCaret = { bg = "#233B48" },
			TelescopeTitle = { fg = "#0B2534", bg = "#0B2534" },
			Folded = { bg = "#233B48", style = { "italic", "bold" } },
			CursorLineNr = { style = { "bold" } },
			TreesitterContext = { bg = "#0B2534" },
			TreesitterContextBottom = { bg = "#0B2534" },
			TreesitterContextLineNumber = { bg = "#0B2534" },
		}
	end,
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
	},
})

vim.cmd.colorscheme("catppuccin")
