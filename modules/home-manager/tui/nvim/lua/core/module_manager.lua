-- File: lua/core/module_manager.lua

local ModuleManager = {
  modules = {},
  lazy_modules = {},
}

function ModuleManager.add(module_name, config)
  if config.lazy then
    ModuleManager.lazy_modules[module_name] = config
  else
    ModuleManager.modules[module_name] = config
  end
end

local function setup_module(module_name, config)
  if not package.loaded[module_name] then
    require(module_name).setup(config.opts or {})
  end
end

function ModuleManager.setup()
  -- Immediately set up non-lazy modules
  for module_name, config in pairs(ModuleManager.modules) do
    setup_module(module_name, config)
  end

  -- Set up lazy loading triggers
  for module_name, config in pairs(ModuleManager.lazy_modules) do
    if config.lazy.keys then
      for _, keymap in ipairs(config.lazy.keys) do
        vim.keymap.set(keymap[1], keymap[2], function()
          setup_module(module_name, config)
          keymap[3]()
        end, { desc = keymap[4] or (module_name .. " keymap") })
      end
    end
    if config.lazy.cmd then
      vim.api.nvim_create_user_command(config.lazy.cmd, function()
        setup_module(module_name, config)
        vim.cmd(config.lazy.cmd)
      end, {})
    end
    -- Add other lazy loading triggers as needed
  end
end

return ModuleManager
