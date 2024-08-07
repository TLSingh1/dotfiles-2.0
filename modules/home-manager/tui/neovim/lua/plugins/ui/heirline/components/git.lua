local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Space = { provider = " " }

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "orange" },

  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "#a6e3a2" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "#f38ba9" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("󰝤 " .. count .. " ")
    end,
    hl = { fg = "#f9e2b0" },
  },
  { -- git branch name
    provider = function(self)
      return self.status_dict.head .. "  "
    end,
    hl = { bold = true }
  },
}

return Git
