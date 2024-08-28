return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = { "bold" },
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
				return {
					InactiveWindow = { bg = "#000000" },
					FloatBorder = { fg = "#011826", bg = "#011826" },
					WinSeparator = { fg = "#011826", bg = "#000000" },
					NeoTreeFloatBorder = { fg = "#011826", bg = "#011826" },
					NeoTreeFloatTitle = { fg = "#011826", bg = "#011826" },
					NeoTreeNormal = { bg = "#011826" },
					NeoTreeTabActive = { bg = "#0B2534" },
					NeoTreeTabSeparatorActive = { fg = "#0B2534", bg = "#0B2534" },
					NoiceCmdLine = { bg = "#000000" },
					TelescopePromptNormal = { fg = "#1affff", bg = "#0B2534" },
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
					NvimTreeNormalFloat = { bg = "#011826" },
					NvimTreeSignColumn = { bg = "#011826" },
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
	end,
}
