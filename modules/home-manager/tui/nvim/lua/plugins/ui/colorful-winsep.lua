return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  config = function()
    require("colorful-winsep").setup({
      hi = {
        bg = "#011826",
        fg = "#011826",
      },
      no_exec_files = { "TelescopePrompt", "neo-tree" },
      symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      only_line_seq = true,
      smooth = true,
      exponential_smoothing = true,
      anchor = {
        left = { height = 1, x = -1, y = -1 },
        right = { height = 1, x = -1, y = 0 },
        up = { width = 0, x = -1, y = 0 },
        bottom = { width = 0, x = 1, y = 0 },
      },
    })
  end,
}
