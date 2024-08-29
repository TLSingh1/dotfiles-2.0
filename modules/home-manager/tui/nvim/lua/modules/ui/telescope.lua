-- ./lua/modules/ui/telescope.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "n", "<leader>f", "<cmd>Telescope find_files<CR>" },
    { "n", "<leader>g", "<cmd>Telescope live_grep<CR>" },
    { "n", "<leader>td", "<cmd>Telescope diagnostics<CR>" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "🔭 ",
        selection_caret = "󱞪 ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<S-k>"] = actions.preview_scrolling_up,
            ["<S-j>"] = actions.preview_scrolling_down,
          },
          n = {
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = true,
        },
      },
    })
  end,
})
