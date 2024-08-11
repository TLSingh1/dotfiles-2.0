local function get_signs(buf, lnum)
	local signs = {}
	local placed_signs = vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs
	for _, sign in ipairs(placed_signs) do
		local defined_sign = vim.fn.sign_getdefined(sign.name)[1]
		if defined_sign then
			local ret = {
				name = defined_sign.name,
				text = defined_sign.text,
				texthl = defined_sign.texthl,
				priority = sign.priority,
			}
			table.insert(signs, ret)
		end
	end

	local extmarks = vim.api.nvim_buf_get_extmarks(
		buf,
		-1,
		{ lnum - 1, 0 },
		{ lnum - 1, -1 },
		{ details = true, type = "sign" }
	)
	for _, extmark in pairs(extmarks) do
		signs[#signs + 1] = {
			name = extmark[4].sign_hl_group or "",
			text = extmark[4].sign_text,
			texthl = extmark[4].sign_hl_group,
			priority = extmark[4].priority,
		}
	end

	table.sort(signs, function(a, b)
		return (a.priority or 0) < (b.priority or 0)
	end)

	return signs
end

local function get_mark(bufnr, lnum)
	local marks = vim.fn.getmarklist(bufnr)
	vim.list_extend(marks, vim.fn.getmarklist())
	for _, mark in ipairs(marks) do
		if mark.pos[1] == bufnr and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
			return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
		end
	end
end

local function icon(sign, len)
	sign = sign or {}
	len = len or 2
	local text = vim.fn.strcharpart(sign.text or "", 0, len)
	text = text .. string.rep(" ", len - vim.fn.strchars(text))
	return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

local function get_severity(sign_name)
	if sign_name:match("Error") then
		return 1
	elseif sign_name:match("Warn") then
		return 2
	elseif sign_name:match("Info") then
		return 3
	elseif sign_name:match("Hint") then
		return 4
	end
	return 5 -- non-diagnostic signs
end

local Signs = {
	provider = function(self)
		local bufnr = self.bufnr
		local signs = get_signs(bufnr, vim.v.lnum)
		local diagnostic_sign, git_sign

		local highest_severity = 5
		for _, s in ipairs(signs) do
			if s.name and s.name:find("GitSign") then
				git_sign = s
			else
				local severity = get_severity(s.name)
				if severity < highest_severity then
					highest_severity = severity
					diagnostic_sign = s
				end
			end
		end

		local mark = get_mark(bufnr, vim.v.lnum)
		-- prioritize marks, then most severe diagnostic, then git signs
		local final_sign = mark or diagnostic_sign or git_sign

		if final_sign then
			return string.format("%-2s", icon(final_sign, 1))
		else
			return "  "
		end
	end,
}

local LineNumbers = {
	provider = function()
		local lnum = vim.v.lnum
		local current_line = vim.api.nvim_win_get_cursor(0)[1]

		if lnum == current_line then
			return string.format("%3d", lnum)
		else
			local rel_num = math.abs(current_line - lnum)
			return string.format("%3d", rel_num)
		end
	end,
}

local StatusColumn = {
	init = function(self)
		self.bufnr = vim.api.nvim_get_current_buf()
	end,

	Signs,
	LineNumbers,
	{ provider = " " },
}

return StatusColumn
