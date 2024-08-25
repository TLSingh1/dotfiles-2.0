local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------- General -----------------------
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<leader>w", ":w <CR>", opts)
keymap("n", "<leader>q", ":q <CR>", opts)
keymap("n", "<leader><leader>q", ":qa <CR>", opts)
keymap("n", "<leader>Y", ":%y <CR>", opts)
keymap("x", "p", "p:let @+=@0<CR>", opts)
keymap("n", "<c-n>", ":bdelete <cr>", opts)
keymap("n", "<leader>;", ":", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", ";", ":Neotree float reveal <CR>", opts)
keymap("n", "<leader>n", ":Neogit <CR>", opts)
keymap("n", "<leader><leader>n", ":NoNeckPain <CR>", opts)
-- keymap("n", "<leader><leader>t", ":TailwindConcealToggle <CR>", opts)
keymap("n", "dm", "", {
	noremap = true,
	silent = true,
	desc = "Delete mark",
	callback = function()
		local mark = vim.fn.nr2char(vim.fn.getchar())
		vim.cmd("delmarks " .. mark)
		print("Deleted mark: " .. mark)
	end,
})
keymap("n", "M", "", {
	noremap = true,
	silent = true,
	desc = "Set mark",
	callback = function()
		local char = vim.fn.nr2char(vim.fn.getchar())
		vim.cmd("normal! m" .. char)
		print("Mark set: " .. char)
	end,
})

keymap("n", "m", "", {
	noremap = true,
	silent = true,
	desc = "Jump to mark",
	callback = function()
		local char = vim.fn.nr2char(vim.fn.getchar())
		vim.cmd("normal! `" .. char)
	end,
})

------------------- Navigation ----------------
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)

------------------- Window --------------------
keymap("n", "<leader>d", ":vs <CR>", opts)
keymap("n", "<leader>s", ":split <CR>", opts)
vim.keymap.set("n", "<C-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").resize_right)
keymap("n", "<leader><leader>h", "<cmd>lua require('smart-splits').swap_buf_left() vim.cmd('wincmd h')<CR>", opts)
keymap("n", "<leader><leader>j", "<cmd>lua require('smart-splits').swap_buf_down() vim.cmd('wincmd j')<CR>", opts)
keymap("n", "<leader><leader>k", "<cmd>lua require('smart-splits').swap_buf_up() vim.cmd('wincmd k')<CR>", opts)
keymap("n", "<leader><leader>l", "<cmd>lua require('smart-splits').swap_buf_right() vim.cmd('wincmd l')<CR>", opts)

------------------- LSP -----------------------
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gN", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", opts)
keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", opts)

---------------- Telescope --------------------
local function find_f()
	require("telescope")
	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")
	builtin.find_files(themes.get_dropdown({ previewer = false }))
end
vim.keymap.set("n", "<leader>f", find_f, opts)
-- keymap("n", "<leader>f", "<cmd>lua find_f()<CR>", opts)
-- keymap(
-- 	"n",
-- 	"<leader>f",
-- 	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
-- 	opts
-- )
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>td", ":Telescope diagnostics <CR>", opts)
