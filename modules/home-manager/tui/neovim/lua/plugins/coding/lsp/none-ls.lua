local null_ls = require("null-ls")

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
    highlight_whole_line = false,
  },
  signs = {
    active = signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  width = 60,
})

vim.diagnostic.open_float = (function(orig)
  return function(opts)
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
    local max_severity = vim.diagnostic.severity.HINT
    for _, d in ipairs(diagnostics) do
      if d.severity < max_severity then
        max_severity = d.severity
      end
    end
    local border_color = ({
      [vim.diagnostic.severity.HINT] = "DiagnosticInfo",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    })[max_severity]
    opts.border = {
      { "╭", border_color },
      { "─", border_color },
      { "╮", border_color },
      { "│", border_color },
      { "╯", border_color },
      { "─", border_color },
      { "╰", border_color },
      { "│", border_color },
    }
    orig(opts)
  end
end)(vim.diagnostic.open_float)

null_ls.setup({
  debug = false,
  sources = {
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.completion.spell,
    -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
  },
})
