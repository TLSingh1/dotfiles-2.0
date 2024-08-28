-- lua/plugins/ui/statuscolumn.lua

local colors =
	{ "#caa6f7", "#c1a6f1", "#b9a5ea", "#b1a4e4", "#aba3dc", "#a5a2d4", "#9fa0cc", "#9b9ec4", "#979cbc", "#949ab3" }

return {
	"nvim-lua/plenary.nvim",
	config = function()
		local function setup_highlights()
			local nvim_set_hl = vim.api.nvim_set_hl
			for i, color in ipairs(colors) do
				nvim_set_hl(0, "Gradient" .. i, { fg = color })
			end
		end
		setup_highlights()

		local function numberColumn()
			local function border()
				return "%#Gradient1#│"
			end
			return table.concat({
				border(),
			})
		end

		-- local function signColumn()
		-- 	return "%s"
		-- end
		--
		-- local function foldColumn()
		-- 	return "%C"
		-- end

		local function statusColumn()
			return table.concat({
				numberColumn(),
				-- foldColumn(),
				-- signColumn(),
			})
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			pattern = "*",
			callback = function()
				local ignored_filetypes = {
					"NvimTree",
					"Avante",
					"AvanteInput",
					"TelescopePrompt",
					"TelescopeResults",
					"NeogitStatus",
					"toggleterm",
					"help",
					"notify",
				}
				if not vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
					vim.wo.statuscolumn = statusColumn()
				else
					vim.wo.statuscolumn = ""
				end
			end,
		})
	end,
	event = "VeryLazy",
}
