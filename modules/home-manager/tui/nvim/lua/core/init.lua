-- Load core modules
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Load and setup modules
local ModuleManager = require("core.module_manager")
ModuleManager.setup()
