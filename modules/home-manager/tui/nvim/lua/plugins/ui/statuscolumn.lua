return {
	"nvim-lua/plenary.nvim",
	config = function()
		local M = {}

		-- Define your statuscolumn components here
		local function numberColumn()
			return "%=%{v:relnum?v:relnum:v:lnum} "
		end

		local function signColumn()
			return "%s"
		end

		local function foldColumn()
			return "%C"
		end

		-- Combine the components
		local function statusColumn()
			local current_ft = vim.bo.filetype
			local ignored_ft = {
				"NvimTree",
			}

			if vim.tbl_contains(ignored_ft, current_ft) then
				return ""
			end

			return table.concat({
				"HELOO",
				-- foldColumn(),
				-- signColumn(),
				-- numberColumn(),
			})
		end

		-- Set the statuscolumn
		vim.o.statuscolumn = statusColumn()

		return M
	end,
}
