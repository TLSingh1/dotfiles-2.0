local resession = require("resession")
resession.setup({
	autosave = {
		enabled = true,
		interval = 120,
		notify = true,
	},
})

vim.keymap.set("n", "<leader><leader>ss", resession.save)
vim.keymap.set("n", "<leader><leader>sl", resession.load)
vim.keymap.set("n", "<leader><leader>sd", resession.delete)

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
