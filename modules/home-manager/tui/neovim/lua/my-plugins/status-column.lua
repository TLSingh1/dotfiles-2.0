local statuscolumn = {}

statuscolumn.border = function()
	-- See how the characters is larger then the rest? That's how we make the border look like a single line
	return "│"
end

statuscolumn.myStatuscolumn = function()
	-- We will store the output in a variable so that we can call multiple functions inside here and add their value to the statuscolumn
	local text = ""

	-- This is just a different way of doing
	--
	-- text = text .. statuscolumn.brorder
	--
	-- This will make a lot more sense as we add more things
	text = table.concat({
		statuscolumn.border(),
	})

	return text
end

return statuscolumn
