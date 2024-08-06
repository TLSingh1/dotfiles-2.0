local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
	"lua_ls",
}

for _, server in ipairs(servers) do
    lspconfig[server].setup({ capabilities = lsp_capabilities })
end
