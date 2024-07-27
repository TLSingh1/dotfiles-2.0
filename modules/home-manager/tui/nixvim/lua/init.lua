local config_path = vim.fn.stdpath('config') .. '/lua'
vim.opt.runtimepath:append(config_path)

require("config")
require("plugins")
