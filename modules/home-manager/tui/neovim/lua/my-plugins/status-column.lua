local statuscolumn = {}

local colors =
	{ "#caa6f7", "#c1a6f1", "#b9a5ea", "#b1a4e4", "#aba3dc", "#a5a2d4", "#9fa0cc", "#9b9ec4", "#979cbc", "#949ab3" }

statuscolumn.border = function()
	-- if vim.v.relnum < 9 then
	-- 	return "%#Gradient_" .. (vim.v.lnum + 1) .. "#│"
	-- else
	-- 	return "%#Gradient_10#│"
	-- end
	return "%#StatusBorder#│"
end

statuscolumn.setHl = function()
	-- for i, color in ipairs(colors) do
	-- 	vim.api.nvim_set_hl(0, "Gradient_" .. i, { fg = color })
	-- end
	vim.api.nvim_set_hl(0, "StatusBorder", {
		fg = "#CBA6F7",
	})
end

statuscolumn.number = function(user_config)
	local text = ""
	local config = vim.tbl_extend("keep", user_config or {}, {
		colors = nil,
		mode = "normal",
	})

	if config.colors ~= nil and vim.islist(config.colors) == true then
		for rel_num, hl in ipairs(config.colors) do
			if (vim.v.relnum + 1) == rel_num then
				text = "%#" .. colors .. "#"
				break
			end
		end

		if text == "" then
			text = "%#" .. config.colors[#config.colors] .. "#"
		end
	end

	if config.mode == "normal" then
		text = text .. vim.v.lnum
	elseif config.mode == "relative" then
		text = text .. vim.v.relnum
	elseif config.mode == "hybrid" then
		return vim.v.relnum == 0 and text .. vim.v.lnum or text .. vim.v.relnum
	end

	return text
end

statuscolumn.folds = function()
	local foldlevel = vim.fn.foldlevel(vim.v.lnum)
	local foldlevel_before = vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and vim.v.lnum - 1 or 1)
	local foldlevel_after =
		vim.fn.foldlevel((vim.v.lnum + 1) <= vim.fn.line("$") and (vim.v.lnum + 1) or vim.fn.line("$"))

	local foldclosed = vim.fn.foldclosed(vim.v.lnum)

	-- Line has nothing to do with folds so we will skip it
	if foldlevel == 0 then
		return " "
	end

	-- Line is a closed fold(I know second condition feels unnecessary but I will still add it)
	if foldclosed ~= -1 and foldclosed == vim.v.lnum then
		return "▶"
	end

	-- I didn't use ~= because it couldn't make a nested fold have a lower level than it's parent fold and it's not something I would use
	if foldlevel > foldlevel_before then
		return "▽"
	end

	-- The line is the last line in the fold
	if foldlevel > foldlevel_after then
		return "╰"
	end

	-- Line is in the middle of an open fold
	return "╎"
end

statuscolumn.myStatuscolumn = function()
	local text = ""

	-- The name should be unique so that it doesn't overwrite one of the default highlight group
	statuscolumn.setHl()

	text = table.concat({
		statuscolumn.border(),
		statuscolumn.number({ mode = "hybrid" }),
		statuscolumn.folds(),
	})

	return text
end

return statuscolumn
