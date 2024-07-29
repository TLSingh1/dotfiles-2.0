require("neorg").setup {
	load = {
		["core.defaults"] = {},
		["core.itero"] = {},
		["core.export.markdown"] = {},
		["core.latex.renderer"] = {
			config = {
				conceal = true,
				render_on_enter = false,
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
					fleeting = "~/Brain/100 Fleeting Notes",
					literature = "~/Brain/200 Literature Notes",
					professional = "~/Brain/300 Professional",
					personal = "~/Brain/400 Personal",
					princeton = "~/Brain/500 Princeton",
					science = "~/Brain/600 Science",
					software = "~/Brain/700 Software Eng",
					technology = "~/Brain/800 Technology",
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
		["external.templates"] = {
      templates_dir = "/home/tai/.dotfiles/modules/home-manager/tui/nixvim/lua/neorg-templates"
        -- default_subcommand = "add", -- or "fload", "load"
        -- keywords = { -- Add your own keywords.
        --   EXAMPLE_KEYWORD = function ()
        --     return require("luasnip").insert_node(1, "default text blah blah")
        --   end,
        -- },
        -- snippets_overwrite = {},
		},
	},
}
