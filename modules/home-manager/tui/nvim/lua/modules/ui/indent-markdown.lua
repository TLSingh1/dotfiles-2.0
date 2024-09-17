-- lua/modules/ui/indent-markdown.lua
local module_manager = require("core.module_manager")

local api = vim.api
local M = {}

M.ns = api.nvim_create_namespace("markdown_indent")

local function get_heading_info(line)
	local _, _, hashes, _ = line:find("^(#+)%s+(.*)")
	if hashes then
		return #hashes, #hashes + 1
	end
	return 0, 0
end

local function is_list_item(line)
	return line:match("^%s*[-*+]%s") or line:match("^%s*%d+%.%s")
end

local function get_list_indent(line)
	local _, indent = line:find("^%s*")
	return indent or 0
end

function M.apply_indentation(bufnr)
	bufnr = bufnr or api.nvim_get_current_buf()
	local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local current_level = 0
	local current_indent = 0
	local in_code_block = false
	local code_block_indent = 0

	M.clear_indentation(bufnr)

	for i, line in ipairs(lines) do
		local is_code_block_delimiter = line:match("^```")

		if is_code_block_delimiter then
			in_code_block = not in_code_block
			if in_code_block then
				code_block_indent = current_indent
			end
		end

		local level, indent = get_heading_info(line)
		if level > 0 then
			current_level = level
			current_indent = indent
			goto continue
		end

		local total_indent = current_indent
		if is_list_item(line) then
			total_indent = total_indent + get_list_indent(line)
		end

		if in_code_block then
			total_indent = code_block_indent
		elseif line:match("^%s*$") then
			goto continue
		end

		api.nvim_buf_set_extmark(bufnr, M.ns, i - 1, 0, {
			virt_text = { { string.rep(" ", total_indent), "Conceal" } },
			virt_text_pos = "inline",
			hl_mode = "combine",
		})

		::continue::
	end
end

function M.clear_indentation(bufnr)
	bufnr = bufnr or api.nvim_get_current_buf()
	api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)
end

function M.setup(opts)
	local group = api.nvim_create_augroup("MarkdownIndent", { clear = true })
	api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = group,
		pattern = "*.md",
		callback = function(ev)
			M.apply_indentation(ev.buf)
		end,
	})

	api.nvim_create_autocmd("InsertEnter", {
		group = group,
		pattern = "*.md",
		callback = function(ev)
			M.clear_indentation(ev.buf)
		end,
	})

	api.nvim_create_user_command("MarkdownIndent", function()
		M.apply_indentation()
	end, {})
end

module_manager.use_custom({
	name = "indent_markdown",
	config = function()
		M.setup({})
	end,
})
