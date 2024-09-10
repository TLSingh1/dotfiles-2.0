local M = {}

-- Table to store all plugins
M.plugins = {}
M.custom_modules = {}

-- add a plugin
function M.use(spec)
	table.insert(M.plugins, spec)
end

-- add a custom module
function M.use_custom(spec)
	table.insert(M.custom_modules, spec)
end

-- determine if a plugin should be lazy loaded
local function should_lazy_load(spec)
	return spec.event or spec.ft or spec.cmd or spec.keys
end

-- apply keymaps
local function apply_keymaps(keymaps)
	for mode, mode_maps in pairs(keymaps) do
		for lhs, rhs in pairs(mode_maps) do
			vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true })
		end
	end
end

-- setup lazy loading
local function setup_lazy_loading(spec)
	local function load_plugin()
		if not package.loaded[spec.name] then
			vim.cmd("packadd " .. spec.name)
			if spec.config then
				spec.config()
			end
		end
	end

	if spec.event then
		vim.api.nvim_create_autocmd(spec.event, {
			callback = load_plugin,
		})
	end

	if spec.ft then
		vim.api.nvim_create_autocmd("FileType", {
			pattern = spec.ft,
			callback = load_plugin,
		})
	end

	if spec.cmd then
		vim.api.nvim_create_user_command(spec.cmd, function(cmd_opts)
			load_plugin()
			vim.cmd(cmd_opts.name .. " " .. vim.fn.join(cmd_opts.fargs, " "))
		end, { nargs = "*" })
	end

	if spec.keys then
		for _, keymap in ipairs(spec.keys) do
			local mode, lhs, rhs = unpack(keymap)
			vim.keymap.set(mode, lhs, function()
				load_plugin()
				local keys = vim.api.nvim_replace_termcodes(rhs, true, false, true)
				vim.api.nvim_feedkeys(keys, "n", false)
			end, { silent = true, noremap = true })
		end
	end

	-- apply keymaps immediately, regardless of lazy loading condition
	if spec.keymaps then
		apply_keymaps(spec.keymaps)
	end
end

-- load all plugins and custom modules
function M.load_plugins()
	for _, spec in ipairs(M.plugins) do
		if should_lazy_load(spec) then
			setup_lazy_loading(spec)
		else
			if spec.config then
				local config_ok, config_err = pcall(spec.config)
				if not config_ok then
					vim.notify(
						"Error in config for " .. spec.name .. ": " .. tostring(config_err),
						vim.log.levels.ERROR
					)
				end
			end
			if spec.keymaps then
				apply_keymaps(spec.keymaps)
			end
		end
	end

	-- load custom modules
	for _, spec in ipairs(M.custom_modules) do
		if spec.config then
			spec.config()
		end
		if spec.keymaps then
			apply_keymaps(spec.keymaps)
		end
	end
end

-- setup the module manager
function M.setup()
	-- load all module files
	local modules = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/modules/**/*.lua", false, true)
	for _, file in ipairs(modules) do
		dofile(file)
	end

	-- load all plugins
	M.load_plugins()
end

return M
