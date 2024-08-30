-- lua/modules/coding/conform.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "conform.nvim",
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "alejandra" },
        markdown = { "prettierd", "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--prose-wrap", "always" },
        },
      },
    })
  end,
})
