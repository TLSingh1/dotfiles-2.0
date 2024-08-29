-- ui/dashboard.lua
local module_manager = require("core.module_manager")

local function create_centered_text(text)
  local width = vim.api.nvim_win_get_width(0)
  local shift = math.floor(width / 2) - math.floor(string.len(text) / 2)
  return string.rep(' ', shift) .. text
end

module_manager.use({
  name = "custom-dashboard",
  event = "VimEnter",
  config = function()
    local dashboard_ns = vim.api.nvim_create_namespace('dashboard')

    local function open_dashboard()
      if vim.fn.argc() ~= 0 or vim.fn.line2byte('$') ~= -1 or vim.o.insertmode or vim.o.modifiable == false then
        return
      end

      vim.cmd('enew')
      vim.cmd('setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nocursorline nocursorcolumn nospell norelativenumber nonumber')

      local lines = {
        '',
        '',
        create_centered_text('Welcome to Neovim'),
        '',
        create_centered_text('Quick Actions:'),
        '',
        create_centered_text('ff - Find File'),
        create_centered_text('fg - Live Grep'),
        create_centered_text('fr - Recent Files'),
        create_centered_text('fb - File Browser'),
        '',
        create_centered_text('Press any key to continue...'),
      }

      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

      local highlight_lines = {
        {line = 2, hl = 'Title'},
        {line = 4, hl = 'String'},
        {line = 6, hl = 'Identifier'},
        {line = 7, hl = 'Identifier'},
        {line = 8, hl = 'Identifier'},
        {line = 9, hl = 'Identifier'},
        {line = 11, hl = 'Comment'},
      }

      for _, hl in ipairs(highlight_lines) do
        vim.api.nvim_buf_add_highlight(0, dashboard_ns, hl.hl, hl.line, 0, -1)
      end

      vim.cmd('redraw')
      vim.fn.getchar()
      vim.cmd('bwipeout')
    end

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = open_dashboard,
      once = true,
    })
  end,
  keymaps = {
    n = {
      ['ff'] = '<cmd>Telescope find_files<CR>',
      ['fg'] = '<cmd>Telescope live_grep<CR>',
      ['fr'] = '<cmd>Telescope oldfiles<CR>',
      ['fb'] = '<cmd>Telescope file_browser<CR>',
    },
  },
})
