-- lua/modules/project/neorg.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "neorg",
	ft = { "norg" },
	config = function()
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
							brain = "~/Neo-Brain",
							fleeting = "~/Neo-Brain/100-Fleeting",
							literature = "~/Neo-Brain/200-Literature",
							professional = "~/Neo-Brain/300-Professional",
							personal = "~/Neo-Brain/400-Personal",
							princeton = "~/Neo-Brain/500-Princeton",
							science = "~/Neo-Brain/600-Science",
							software = "~/Neo-Brain/700-Software",
						},
						index = "index.norg",
					},
				},
				-- ["core.esupports.metagen"] = {
				-- 	config = {
				-- 		type = "auto",
				-- 	},
				-- },
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
						name = "[Neorg]",
					},
				},
			},
		})
	end,
})
