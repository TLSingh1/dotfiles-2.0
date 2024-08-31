-- lua/modules/ui/statusline.lua
local module_manager = require("core.module_manager")

module_manager.use_custom({
	name = "custom_statusline",
	config = function()
		local function mode()
			local mode_map = {
				n = "NORMAL",
				i = "INSERT",
				v = "VISUAL",
				V = "V-LINE",
				[""] = "V-BLOCK",
				c = "COMMAND",
				R = "REPLACE",
				t = "TERMINAL",
			}
			return mode_map[vim.api.nvim_get_mode().mode] or "UNKNOWN"
		end

		local function filepath()
			local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
			return fpath == "." and "" or fpath .. "/"
		end

		local function filename()
			local fname = vim.fn.expand("%:t")
			return fname == "" and "[No Name]" or fname
		end

		local function lsp()
			local count = {}
			local levels = {
				errors = vim.diagnostic.severity.ERROR,
				warnings = vim.diagnostic.severity.WARN,
				info = vim.diagnostic.severity.INFO,
				hints = vim.diagnostic.severity.HINT,
			}

			for k, level in pairs(levels) do
				count[k] = #vim.diagnostic.get(0, { severity = level })
			end

			local errors = ""
			local warnings = ""
			local hints = ""
			local info = ""

			if count["errors"] ~= 0 then
				errors = " %#ErrorMsg#󰅚 " .. count["errors"]
			end
			if count["warnings"] ~= 0 then
				warnings = " %#WarningMsg#󰀦 " .. count["warnings"]
			end
			if count["hints"] ~= 0 then
				hints = " %#HintMsg#󰌵 " .. count["hints"]
			end
			if count["info"] ~= 0 then
				info = " %#InfoMsg#󰋼 " .. count["info"]
			end

			return errors .. warnings .. hints .. info .. "%#Normal#"
		end

		local function filetype()
			return vim.bo.filetype
		end

		local function lineinfo()
			return vim.fn.line(".") .. ":" .. vim.fn.col(".")
		end

		function StatusLine()
			return table.concat({
				"%#Normal#",
				" ",
				mode(),
				" %#Normal#",
				" ",
				filepath(),
				filename(),
				"%m",
				"%=",
				lsp(),
				" ",
				filetype(),
				" ",
				lineinfo(),
				" ",
			})
		end

		vim.o.statusline = "%!v:lua.StatusLine()"
	end,
})
