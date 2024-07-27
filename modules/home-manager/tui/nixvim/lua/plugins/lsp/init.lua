local lspconfig = require('lspconfig')

-- Define a function to set up lua_ls
local function setup_lua_ls()
  lspconfig.lua_ls.setup {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
    }
  }
end

-- Set up lua_ls
setup_lua_ls()

-- Return the setup function so we can use it later
return {
  setup_lua_ls = setup_lua_ls
}
