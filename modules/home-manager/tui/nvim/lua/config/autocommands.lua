-- autocmd to make help buffers normal buffers
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function(event)
		if vim.bo[event.buf].filetype == "help" then
			-- Set the buffer as listed
			vim.bo[event.buf].buflisted = true
			-- Convert the help window to a normal buffer
			vim.bo[event.buf].buftype = ""
			-- Keep it read-only
			vim.bo[event.buf].modifiable = false
			vim.bo[event.buf].readonly = true
			-- Open in a full window
			vim.cmd.only()
			-- Optionally, set a buffer-local keymap to quit
			vim.api.nvim_buf_set_keymap(event.buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
		end
	end,
})
