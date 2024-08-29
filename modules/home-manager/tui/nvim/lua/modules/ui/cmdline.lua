-- lua/modules/ui/custom_cmdline.lua
local module_manager = require("core.module_manager")

local cmd = {}

-- Namespace for highlights, extmarks & ui-events
-- cmd.ns = vim.api.nvim_create_namespace("cmd")
-- Buffer holding the cmdline text
-- cmd.buf = vim.api.nvim_create_buf(false, true)
-- We will store the cmdline window here later
-- cmd.win = nil
-- Store cursor info, so that we can unhide it later
-- cmd.cursor = nil

-- Table to store all of the provided variables
-- cmd.state = {}

-- Wrapper function to update state
-- cmd.update_state = function(state)
--   cmd.state = vim.tbl_extend("force", cmd.state, state)
-- end

module_manager.use({
  name = "custom_cmdline",
  config = function()
    vim.print("commandline loaded")
  end
})
