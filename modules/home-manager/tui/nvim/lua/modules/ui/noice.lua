-- lua/modules/ui/noice.lua
local module_manager = require("core.module_manager")

module_manager.use({
  name = "noice.nvim",
  event = "VimEnter",
  config = function()
    require("noice").setup({
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
        {
          view = "mini",
          filter = { find = "written" },
          opts = { skip = true },
        },
        {
          view = "mini",
          filter = { find = "yanked" },
        },
        {
          view = "mini",
          filter = { find = "more" },
        },
        {
          view = "mini",
          filter = { find = "fewer" },
        },
        {
          view = "mini",
          filter = { find = "change" },
        },
        {
          filter = { find = "Failed to attach to nixd" },
          opts = { skip = true },
        },
        {
          filter = { find = "Failed to attach to nil_ls" },
          opts = { skip = true },
        },
      },
    })
  end,
})

-- Ensure dependencies are loaded
module_manager.use({ name = "nui.nvim" })
module_manager.use({ name = "nvim-notify" })
