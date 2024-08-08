-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "help",
-- 	callback = function()
-- 		vim.cmd("wincmd L")
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local win = vim.api.nvim_get_current_win()

		-- Try to open in a vertical split first
		vim.cmd("wincmd L")
		vim.cmd("vertical resize 80") -- Set a reasonable width, adjust as needed

		-- Check if the split was successful
		if vim.api.nvim_win_get_width(win) < 80 then
			-- If the split resulted in a too-narrow window, go full-screen instead
			vim.api.nvim_win_close(win, false)
			vim.cmd("enew")
			vim.api.nvim_win_set_buf(0, buf)
			vim.cmd("only") -- Make it full-screen
		end

		-- Set buffer options to make it easy to close
		vim.api.nvim_set_option_value("buflisted", true, { buf = buf })
		vim.api.nvim_set_option_value("buftype", "help", { buf = buf })
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "help",
-- 	callback = function()
-- 		local buf = vim.api.nvim_get_current_buf()
-- 		local win = vim.api.nvim_get_current_win()
--
-- 		-- Try to open in a vertical split first
-- 		vim.cmd("wincmd L")
-- 		vim.cmd("vertical resize 100") -- Increased from 80 to 100
--
-- 		-- Check if the split was successful
-- 		if vim.api.nvim_win_get_width(win) < 100 then -- Increased from 80 to 100
-- 			-- If the split resulted in a too-narrow window, go full-screen instead
-- 			vim.api.nvim_win_close(win, false)
-- 			vim.cmd("enew")
-- 			vim.api.nvim_win_set_buf(0, buf)
-- 			vim.cmd("only") -- Make it full-screen
-- 		end
--
-- 		-- Set buffer options to make it easy to close
-- 		vim.api.nvim_set_option_value("buflisted", true, { buf = buf })
-- 		vim.api.nvim_set_option_value("buftype", "help", { buf = buf })
-- 	end,
-- })
