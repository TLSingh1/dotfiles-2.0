require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.itero"] = {},
		["core.export.markdown"] = {},
		["core.latex.renderer"] = {
			config = {
				conceal = true,
				render_on_enter = true,
			},
		},
		["core.keybinds"] = {
			config = {
				hook = function(keybinds)
					keybinds.unmap("norg", "n", "<LocalLeader>li")
					keybinds.remap_key("norg", "n", "<LocalLeader>lt", "<LocalLeader>nL")
				end,
			},
		},
		["core.concealer"] = {
			config = {
				icon_preset = "varied",
				icons = {
					code_block = {
						conceal = true,
						content_only = true,
						highlight = "CursorLine",
					},
				},
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					brain = "~/Brain",
					fleeting = "~/Brain/100-Fleeting",
					literature = "~/Brain/200-Literature",
					professional = "~/Brain/300-Professional",
					personal = "~/Brain/400-Personal",
					princeton = "~/Brain/500-Princeton",
					science = "~/Brain/600-Science",
					software = "~/Brain/700-Software",
				},
				index = "index.norg",
			},
		},
		["core.esupports.metagen"] = {
			config = {
				type = "auto",
			},
		},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
				name = "[Neorg]",
			},
		},
		-- ["external.templates"] = {
		-- 	templates_dir = "/home/tai/.dotfiles/modules/home-manager/tui/neovim/lua/norg-templates",
		-- },
	},
})
