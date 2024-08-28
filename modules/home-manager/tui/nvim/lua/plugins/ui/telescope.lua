-- File: lua/plugins/ui/telescope.lua

local M = {}

local function setup_telescope()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },
      file_ignore_patterns = { ".git/", "node_modules" },
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  -- Load fzf extension
  telescope.load_extension('fzf')
end

-- Function to lazy load Telescope
local function lazy_telescope(callback)
  if package.loaded["telescope"] then
    callback()
  else
    vim.cmd("doautocmd User TelescopeLoad")
    callback()
  end
end

-- Set up keymaps
local function set_keymaps()
  vim.keymap.set('n', '<leader>ff', function()
    lazy_telescope(function()
      require('telescope.builtin').find_files()
    end)
  end, { desc = "Find files" })

  vim.keymap.set('n', '<leader>fg', function()
    lazy_telescope(function()
      require('telescope.builtin').live_grep()
    end)
  end, { desc = "Live grep" })

  vim.keymap.set('n', '<leader>fb', function()
    lazy_telescope(function()
      require('telescope.builtin').buffers()
    end)
  end, { desc = "Buffers" })

  vim.keymap.set('n', '<leader>fh', function()
    lazy_telescope(function()
      require('telescope.builtin').help_tags()
    end)
  end, { desc = "Help tags" })
end

-- Initialize function
function M.init()
  -- Create autocommand for lazy loading
  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopeLoad",
    callback = function()
      setup_telescope()
    end,
  })

  -- Set up keymaps
  set_keymaps()
end

return M
