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
	custom_highlights = function(colors)
		return {
			WinSeparator = { fg = "#011826", bg = "#000000" },
			NeoTreeFloatBorder = { fg = "#011826", bg = "#011826" },
			NeoTreeFloatTitle = { fg = "#011826" },
			NoiceCmdLine = { bg = "#000000" },
			TelescopePromptNormal = { bg = "#0B2534" },
			TelescopePromptBorder = { fg = "#0B2534", bg = "#0B2534" },
			TelescopePrompt = { fg = "#0B2534", bg = "#0B2534" },
			TelescopeBorder = { fg = "#011826", bg = "#011826" },
			TelescopeSelection = { bg = "#233B48" },
			TelescopeSelectionCaret = { bg = "#233B48" },
			TelescopeTitle = { fg = "#0B2534", bg = "#0B2534" },
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
