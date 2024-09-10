-- lua/modules/coding/ufo.lua
local module_manager = require("core.module_manager")

module_manager.use({
	name = "nvim-ufo",
	config = function()
		local ufo = require("ufo")

		ufo.setup({
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				json = { "array" },
				c = { "comment", "region" },
			},
			open_fold_hl_timeout = 0,
			-- provider_selector = function(_, _)
			-- 	return { "treesitter", "indent" }
			-- end,
			fold_virt_text_handler = function(_, lnum, end_lnum, _, _)
				local _start = lnum - 1
				local _end = end_lnum - 1
				local start_text = vim.api.nvim_buf_get_text(0, _start, 0, _start, -1, {})[1]
				local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
				return start_text .. " ⋯ " .. final_text .. (" 󰁂 %d "):format(end_lnum - lnum)
			end,
		})
	end,
	keymaps = {
		n = {
			["zR"] = function()
				require("ufo").openAllFolds()
			end,
			["zM"] = function()
				require("ufo").closeAllFolds()
			end,
			["zr"] = function()
				require("ufo").openFoldsExceptKinds()
			end,
			["zm"] = function()
				require("ufo").closeFoldsWith()
			end, -- closeAllFolds == closeFoldsWith(0)
			["K"] = function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
		},
	},
})
