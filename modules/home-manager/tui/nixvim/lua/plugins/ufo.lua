local ufo = require('ufo')

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local lspconfig = require("lspconfig")
local language_servers = lspconfig.util.available_servers()

for _, ls in ipairs(language_servers) do
  local current_capabilities = lspconfig[ls].document_config.default_config.capabilities or {}
  lspconfig[ls].setup({
    capabilities = vim.tbl_deep_extend('force', current_capabilities, capabilities)
  })
end

-- Re-setup lua_ls with the merged capabilities
local lua_ls_setup = require('plugins.lsp').setup_lua_ls
lua_ls_setup()

ufo.setup()
