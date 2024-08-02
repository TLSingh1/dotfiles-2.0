local config_path = vim.fn.stdpath('config') .. '/lua'
vim.opt.runtimepath:append(config_path)

local function read_file(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read("*all")
    file:close()
    return content
end

local api_key_path = "/run/secrets/claude"
local api_key = read_file(api_key_path)

if api_key then
    api_key = api_key:gsub("%s+", "")
    vim.g.claude_api_key = api_key
else
    print("Failed to read API key from " .. api_key_path)
end

require("config")
require("plugins")
