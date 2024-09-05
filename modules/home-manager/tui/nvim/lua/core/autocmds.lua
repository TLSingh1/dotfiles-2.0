local function setup_neorg_image_display()
	local ns_id = vim.api.nvim_create_namespace("neorg_image_display")

	local function process_buffer()
		local bufnr = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

		-- Clear all existing extmarks and matches
		vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
		vim.fn.clearmatches()

		for lnum, line in ipairs(lines) do
			local start, _, path = line:find("^%.image%s+(.+)$")
			if start then
				local filename = path:match("([^/]+)%.%w+$")
				if filename then
					if lnum ~= cursor_line then
						-- Conceal the entire line
						vim.fn.matchadd("Conceal", "\\v\\c^.image.*$", 11, -1, { conceal = "" })

						-- Add extmark for "IM" prefix and filename
						vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum - 1, 0, {
							virt_text = { { "  " .. filename, "Special" } },
							virt_text_pos = "overlay",
							hl_mode = "combine",
							priority = 100,
						})
					end
				end
			end
		end
	end

	-- Process the buffer initially
	process_buffer()

	-- Set up autocommands to reprocess on file change and cursor movement
	local group = vim.api.nvim_create_augroup("NeorgImageDisplay", { clear = true })
	vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "TextChangedI", "CursorMoved", "CursorMovedI" }, {
		group = group,
		buffer = vim.api.nvim_get_current_buf(),
		callback = process_buffer,
	})

	-- Set conceallevel and concealcursor
	vim.opt_local.conceallevel = 2
	vim.opt_local.concealcursor = ""
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "norg",
	callback = function()
		setup_neorg_image_display()
	end,
})
