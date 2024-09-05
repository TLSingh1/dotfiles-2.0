local function setup_neorg_image_display()
	local ns_id = vim.api.nvim_create_namespace("neorg_image_display")

	local function process_buffer()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

		-- clear existing extmarks and matches
		vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
		vim.fn.clearmatches()

		for lnum, line in ipairs(lines) do
			local start, _, indent, path = line:find("^(%s*)%.image%s+(.+)$")
			if start then
				local filename = path:match("([^/]+)%.%w+$")
				if filename then
					if lnum ~= cursor_line then
						vim.fn.matchadd("Conceal", "\\v\\c^\\s*.image.*$", 11, -1, { conceal = "" })
						vim.api.nvim_buf_set_extmark(0, ns_id, lnum - 1, 0, {
							virt_text = { { indent .. "  " .. filename, "Special" } },
							virt_text_pos = "overlay",
							hl_mode = "combine",
							priority = 100,
						})
					end
				end
			end
		end
	end

	process_buffer()

	local group = vim.api.nvim_create_augroup("NeorgImageDisplay", {})
	vim.api.nvim_create_autocmd({ "BufWritePost", "CursorMoved", "CursorMovedI" }, {
		group = group,
		buffer = vim.api.nvim_get_current_buf(),
		callback = process_buffer,
	})

	vim.opt_local.conceallevel = 2
	vim.opt_local.concealcursor = ""
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "norg",
	callback = function()
		setup_neorg_image_display()
	end,
})
