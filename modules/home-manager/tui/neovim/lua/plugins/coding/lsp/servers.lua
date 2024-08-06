local lspconfig = require("lspconfig")
local lsp_format = require("lsp-format")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp_format.setup({})

local servers = {
  "lua_ls",
  "nil_ls",
  "nixd",
}

local function setup_lua_ls()
  return {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
        runtime = {
          version = 'LuaJIT'
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
    end,
    settings = {
      Lua = {}
    },
    capabilities = lsp_capabilities,
    on_attach = lsp_format.on_attach
  }
end

local function on_attach(client, bufnr)
  lsp_format.on_attach(client, bufnr)
  -- add other custom on_attach logic here
end

for _, server in ipairs(servers) do
  if server == "lua_ls" then
    lspconfig[server].setup(setup_lua_ls())
  else
    lspconfig[server].setup({
      capabilities = lsp_capabilities,
      on_attach = on_attach
    })
  end
end
