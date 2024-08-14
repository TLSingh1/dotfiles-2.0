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
