local NixShell = {
	condition = function()
		return vim.env.IN_NIX_SHELL ~= nil
	end,
	provider = function()
		local shell_name = vim.env.IN_NIX_SHELL or "nix-shell"
		return " " .. shell_name .. " "
	end,
	hl = { fg = "#7FBBB3", bg = "#1E1E2E" }, -- Adjust colors as needed
}

return NixShell
