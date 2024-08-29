-- core/module_manager.lua
local M = {}

-- Table to store all plugins
M.plugins = {}

-- Function to add a plugin
function M.use(spec)
    table.insert(M.plugins, spec)
end

-- Function to determine if a plugin should be lazy loaded
local function should_lazy_load(spec)
    return spec.event or spec.ft or spec.cmd or spec.keys
end

-- Function to apply keymaps
local function apply_keymaps(keymaps)
    for mode, mode_maps in pairs(keymaps) do
        for lhs, rhs in pairs(mode_maps) do
            vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true })
        end
    end
end

-- Function to setup lazy loading
local function setup_lazy_loading(spec)
    local lazyload = {}
    if spec.event then
        lazyload.event = spec.event
    elseif spec.ft then
        lazyload.ft = spec.ft
    elseif spec.cmd then
        lazyload.cmd = spec.cmd
    elseif spec.keys then
        lazyload.keys = spec.keys
    end

    if next(lazyload) then
        vim.api.nvim_create_autocmd(lazyload.event or "FileType", {
            pattern = lazyload.ft,
            callback = function()
                if not package.loaded[spec.name] then
                    vim.cmd("packadd " .. spec.name)
                    if spec.config then
                        spec.config()
                    end
                end
            end,
        })
    end

    -- Apply keymaps immediately, regardless of lazy loading condition
    if spec.keymaps then
        apply_keymaps(spec.keymaps)
    end
end

-- Function to load all plugins
function M.load_plugins()
    for _, spec in ipairs(M.plugins) do
        if should_lazy_load(spec) then
            setup_lazy_loading(spec)
        else
            vim.cmd("packadd " .. spec.name)
            if spec.config then
                spec.config()
            end
            if spec.keymaps then
                apply_keymaps(spec.keymaps)
            end
        end
    end
end

-- Function to setup the module manager
function M.setup()
    -- Load all module files
    local modules = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/modules/**/*.lua", false, true)
    for _, file in ipairs(modules) do
        dofile(file)
    end

    -- Load all plugins
    M.load_plugins()
end

return M
