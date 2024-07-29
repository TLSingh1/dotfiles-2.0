require("winbar").setup({
  icons = true,
  diagnostics = true,
  buf_modified = true,
  buf_modified_symbol = "●",
  dim_inactive = {
      enabled = false,
      highlight = "WinBarNC",
      icons = true, -- whether to dim the icons
      name = true, -- whether to dim the name
  }
})
