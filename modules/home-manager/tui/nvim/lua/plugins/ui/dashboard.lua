local M = {}

M.setup = function()
	local dashboard = {}

	dashboard.open = function()
		-- Create a new buffer for the dashboard
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_set_current_buf(buf)

		-- Set buffer options
		vim.bo[buf].buftype = "nofile"
		vim.bo[buf].swapfile = false
		vim.bo[buf].bufhidden = "wipe"

		-- Create content
		local width = vim.api.nvim_win_get_width(0)
		local function center(str)
			local padding = math.floor((width - #str) / 2)
			return string.rep(" ", padding) .. str
		end

		local stats = require("lazy").stats()
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		local startup_message = string.format("⚡ Neovim loaded %d plugins in %.2f ms", stats.count, ms)

		local lines = {
			"",
			center("Welcome to Neovim!"),
			"",
			center(startup_message),
			"",
			center("Quick Actions:"),
			center("[e] New file"),
			center("[f] Find file"),
			center("[r] Recent files"),
			center("[s] Settings"),
			center("[q] Quit"),
			"",
		}

		-- Add content to buffer
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

		-- Center content vertically
		local height = vim.api.nvim_win_get_height(0)
		local start_line = math.floor((height - #lines) / 2)
		vim.api.nvim_win_set_cursor(0, { start_line, 0 })

		-- Set buffer to read-only
		vim.bo[buf].modifiable = false

		-- Set up keymaps
		local opts = { noremap = true, silent = true, buffer = buf }
		vim.keymap.set("n", "e", ":enew<CR>", opts)
		vim.keymap.set("n", "f", ":Telescope find_files<CR>", opts)
		vim.keymap.set("n", "r", ":Telescope oldfiles<CR>", opts)
		vim.keymap.set("n", "s", ":e $MYVIMRC<CR>", opts)
		vim.keymap.set("n", "q", ":q<CR>", opts)
	end

	-- Create an autocmd to open the dashboard on startup
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			-- Only open dashboard if no files were specified
			if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
				dashboard.open()
			end
		end,
	})

	-- Command to manually open the dashboard
	vim.api.nvim_create_user_command("Dashboard", dashboard.open, {})
end

return M
