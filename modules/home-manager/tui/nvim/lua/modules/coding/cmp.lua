-- lua/modules/coding/nvim-cmp.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-cmp",
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")

		luasnip.filetype_extend("javascript", { "html" })
		luasnip.filetype_extend("javascriptreact", { "html" })
		luasnip.filetype_extend("typescriptreact", { "html" })
		luasnip.filetype_extend("typescript", { "javascript" })
		require("luasnip/loaders/from_vscode").load({ include = { "html" } })
		require("luasnip/loaders/from_vscode").lazy_load()

		local kind_icons = {
			Text = "󰉿 ",
			Method = "󰆧 ",
			Function = "󰊕 ",
			Constructor = " ",
			Field = "󰜢 ",
			Variable = "󰀫 ",
			Class = "󰠱 ",
			Interface = " ",
			Module = " ",
			Property = "󰜢 ",
			Unit = "󰑭 ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Color = " ",
			File = "󰈙 ",
			Reference = "󰈇 ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = "󰙅 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "𝙏",
		}

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<S-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<S-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-y>"] = cmp.config.disable,
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "neorg" },
				{ name = "luasnip", option = { show_autosnippets = true } },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "emoji" },
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				documentation = cmp.config.window.bordered(),
			},
			experimental = {
				ghost_text = false,
				native_menu = false,
			},
		})
	end,
})
