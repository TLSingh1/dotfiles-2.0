-- core/module_manager.lua
local module_manager = {}

function module_manager.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      print("Hello")
    end,
  })
end

return module_manager
