-- NOTE: force help pages to open in vsplit
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local win = vim.api.nvim_get_current_win()

		vim.cmd("wincmd L")
		vim.cmd("vertical resize 90")

		if vim.api.nvim_win_get_width(win) < 90 then
			vim.api.nvim_win_close(win, false)
			vim.cmd("enew")
			vim.api.nvim_win_set_buf(0, buf)
			vim.cmd("only")
		end

		vim.api.nvim_set_option_value("buflisted", true, { buf = buf })
		vim.api.nvim_set_option_value("buftype", "help", { buf = buf })
	end,
})
