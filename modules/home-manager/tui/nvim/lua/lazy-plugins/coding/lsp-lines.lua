return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lsp_lines").setup()
  end,
}
