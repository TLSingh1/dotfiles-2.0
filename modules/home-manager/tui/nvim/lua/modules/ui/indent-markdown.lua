-- lua/modules/ui/indent-markdown.lua
local module_manager = require("core.module_manager")

module_manager.use_custom({
	name = "indent_markdown",
	config = function()
		local api = vim.api
		local M = {}

		-- Configuration
		M.config = {
			indent_size = 2,
			ignore_code_blocks = true,
		}

		-- Namespace for extmarks
		M.ns = api.nvim_create_namespace("markdown_indent")

		-- Function to detect heading level
		local function get_heading_level(line)
			local _, _, level = line:find("^(#+)%s+")
			return level and #level or 0
		end

		-- Function to detect list item
		local function is_list_item(line)
			return line:match("^%s*[-*+]%s") or line:match("^%s*%d+%.%s")
		end

		-- Function to get list item indentation
		local function get_list_indent(line)
			local _, indent = line:find("^%s*")
			return indent or 0
		end

		-- Function to apply indentation
		function M.apply_indentation(bufnr)
			bufnr = bufnr or api.nvim_get_current_buf()
			local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local current_level = 0
			local in_code_block = false

			for i, line in ipairs(lines) do
				if M.config.ignore_code_blocks then
					if line:match("^```") then
						in_code_block = not in_code_block
					end
				end

				if not in_code_block then
					local level = get_heading_level(line)
					if level > 0 then
						current_level = level
					elseif not line:match("^%s*$") then -- Skip empty lines
						local indent = current_level * M.config.indent_size
						if is_list_item(line) then
							indent = indent + get_list_indent(line)
						end

						-- Apply indentation using extmarks without hiding the original text
						api.nvim_buf_set_extmark(bufnr, M.ns, i - 1, 0, {
							virt_text = { { string.rep(" ", indent), "Conceal" } },
							virt_text_pos = "inline",
							hl_mode = "combine",
						})
					end
				end
			end
		end

		-- Function to clear all indentation
		function M.clear_indentation(bufnr)
			bufnr = bufnr or api.nvim_get_current_buf()
			api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)
		end

		-- Setup function
		function M.setup(opts)
			M.config = vim.tbl_deep_extend("force", M.config, opts or {})

			-- Create autocommands
			local group = api.nvim_create_augroup("MarkdownIndent", { clear = true })
			api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = group,
				pattern = "*.md",
				callback = function(ev)
					M.apply_indentation(ev.buf)
				end,
			})

			-- Add command to manually trigger indentation
			api.nvim_create_user_command("MarkdownIndent", function()
				M.apply_indentation()
			end, {})
		end

		M.setup({
			indent_size = 2,
			ignore_code_blocks = true,
		})
	end,
})
