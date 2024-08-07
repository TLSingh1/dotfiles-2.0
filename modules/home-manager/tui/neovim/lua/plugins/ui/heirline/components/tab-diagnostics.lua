local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")

local TabDiagnostics = {
  condition = function(self)
    return conditions.has_diagnostics(self.bufnr)
  end,

  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1],
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1],
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1],
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1],
  },

  init = function(self)
    local diagnostics = vim.diagnostic.get(self.bufnr)
    local count = { 0, 0, 0, 0 }
    for _, diagnostic in ipairs(diagnostics) do
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
    self.errors = count[vim.diagnostic.severity.ERROR]
    self.warnings = count[vim.diagnostic.severity.WARN]
    self.info = count[vim.diagnostic.severity.INFO]
    self.hints = count[vim.diagnostic.severity.HINT]

    self.error_icon = " "
    self.warn_icon = " "
    self.info_icon = " "
    self.hint_icon = " "
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = " ",
  },
  {
    provider = function(self)
      if self.errors > 0 then
        return self.error_icon .. self.errors
      elseif self.warnings > 0 then
        return self.warn_icon .. self.warnings
      elseif self.info > 0 then
        return self.info_icon .. self.info
      elseif self.hints > 0 then
        return self.hint_icon .. self.hints
      else
        return ""
      end
    end,
    hl = function(self)
      if self.errors > 0 then
        return { fg = "#f38ba8" }
      elseif self.warnings > 0 then
        return { fg = "#f9e2af" }
      elseif self.info > 0 then
        return { fg = "#89dceb" }
      elseif self.hints > 0 then
        return { fg = "#94e2d5" }
      end
    end,
  },
}

return TabDiagnostics
