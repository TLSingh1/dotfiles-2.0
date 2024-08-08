local M = {}

local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("*all")
	file:close()
	return content
end

function M.setup()
	-- Existing API key configuration
	local api_key_path = "/run/secrets/claude"
	local api_key = read_file(api_key_path)

	if api_key then
		api_key = api_key:gsub("%s+", "")
		vim.g.claude_api_key = api_key
	else
		print("Failed to read API key from " .. api_key_path)
	end

	-- New configuration for vertical split
	vim.g.claude_chat_split = "vertical"

	-- You can add more Claude.vim specific configurations here
end

return M
