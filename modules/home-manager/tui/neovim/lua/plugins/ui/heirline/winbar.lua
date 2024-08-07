local conditions = require("heirline.conditions")
local path = require("plenary.path")
local devicons = require("nvim-web-devicons")

local WinBar = {
  fallthrough = false,

  {
    -- condition = conditions.is_active,
    init = function(self)
      -- Get the full path of the current buffer
      self.filename = vim.api.nvim_buf_get_name(0)

      -- Find the project root
      local root = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
      local git_dir = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')
      if git_dir ~= '' then
        root = vim.fn.fnamemodify(git_dir, ':h')
      end

      -- Get relative path from project root
      self.rel_path = path:new(self.filename):make_relative(root)

      -- Split the path
      self.parts = vim.split(self.rel_path, path.path.sep)

      -- Get file icon
      local filename = self.parts[#self.parts]
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
    end,

    -- Grandparent directory
    {
      provider = function(self)
        if #self.parts > 2 then
          return self.parts[#self.parts - 2] .. " / "
        end
        return ""
      end,
      hl = { fg = "gray" },
    },

    -- Parent directory
    {
      provider = function(self)
        if #self.parts > 1 then
          return self.parts[#self.parts - 1] .. " / "
        end
        return ""
      end,
      hl = { fg = "lightgray" },
    },

    -- File icon
    {
      provider = function(self)
        return self.icon and (self.icon .. " ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    },

    -- File name
    {
      provider = function(self)
        return self.parts[#self.parts]
      end,
      hl = { fg = "white", bold = true },
    },
  },

  -- Fallback if the window is not active
  -- {
  --   provider = "",
  -- },
}

return WinBar
