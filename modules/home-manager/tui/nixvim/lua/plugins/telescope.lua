require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- Set the width (0-1 for percentage, >1 for absolute column count)
        width = 0.6,
        -- Set the height (0-1 for percentage, >1 for absolute row count)
        height = 0.6,
        -- You can add other layout_config options here as well
      }
    }
  }
}
require("telescope").load_extension("ui-select")
