-- lua/modules/coding/lspconfig.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- local navic = require("nvim-navic")
		-- local navbuddy = require("nvim-navbuddy")

		lsp_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local servers = {
			"lua_ls",
			"nil_ls",
			"nixd",
			"svelte",
			"tailwindcss",
			"cssls",
			"html",
			"jsonls",
			"terraformls",
		}

		local function on_attach(client, bufnr)
			-- lsp_format.on_attach(client, bufnr)
			-- add other on_attach logic here
			if client.server_capabilities.documentSymbolProvider then
				-- navic.attach(client, bufnr)
				-- navbuddy.attach(client, bufnr)
			end
		end

		local function setup_lua_ls()
			return {
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
				settings = {
					Lua = {},
				},
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			}
		end

		for _, server in ipairs(servers) do
			if server == "lua_ls" then
				lspconfig[server].setup(setup_lua_ls())
			else
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
					on_attach = on_attach,
				})
			end
		end
	end,
})
