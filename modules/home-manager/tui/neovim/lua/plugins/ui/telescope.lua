local telescope = require("telescope")

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "nerdy")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "🔭 ",
    selection_caret = "✨",
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
      }
    }
  }
})
