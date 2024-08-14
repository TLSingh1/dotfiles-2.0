local resession = require("resession")

-- autocmd to make help page normal buffers
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function(event)
		if vim.bo[event.buf].filetype == "help" then
			vim.bo[event.buf].buflisted = true
			vim.bo[event.buf].buftype = ""
			vim.bo[event.buf].modifiable = false
			vim.bo[event.buf].readonly = true
			vim.cmd.only()
			vim.api.nvim_buf_set_keymap(event.buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
		end
	end,
})

local mode_group = vim.api.nvim_create_augroup("MoodyModeGroup", { clear = true })

-- only show cursorline in active window
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = mode_group,
	callback = function(_)
		local win = vim.api.nvim_get_current_win()
		vim.api.nvim_set_option_value("cursorline", true, {
			win = win,
		})
	end,
})

-- hide cursorline in inactive windows
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = mode_group,
	callback = function(_)
		local win = vim.api.nvim_get_current_win()
		vim.api.nvim_set_option_value("cursorline", false, {
			win = win,
		})
	end,
})

-- resession: save on quit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		-- Always save a special session named "last"
		resession.save("last")
	end,
})

-- resession: load dir-specific session when running nvim w/no args in relevant dir
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Only load the session if nvim was started with no args
		if vim.fn.argc(-1) == 0 then
			-- Save these to a different directory, so our manual sessions don't get polluted
			resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
		end
	end,
	nested = true,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
	end,
})
