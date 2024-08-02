-- local zen_mode_group = vim.api.nvim_create_augroup("ZenModeAutogroup", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = zen_mode_group,
--   pattern = "*.norg",
--   callback = function()
--     vim.cmd.ZenMode()
--   end,
-- })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.bo.filetype == 'help' then
      vim.cmd.wincmd("L")
    end
  end
})
