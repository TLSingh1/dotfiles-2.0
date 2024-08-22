local notify = require("notify")
vim.notify = notify;

notify.setup({
  timeout = 300,
  render = "minimal"
})
