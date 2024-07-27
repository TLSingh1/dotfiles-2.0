local lualine = require("lualine")
local function file_path_with_parent()
  local file = vim.fn.expand('%:t')
  local parent = vim.fn.expand('%:h:t')
  if parent == '.' then
    return file
  else
    return parent .. '/' .. file
  end
end
local colors = {
  bg       = '#000000',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
local cursor_symbols = {
  "▁",
  "▂",
  "▃",
  "▄",
  "▅",
  "▆",
  "▇",
  "█",
}
local function cursor_location()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local percentage = math.floor((current_line / total_lines) * 100)
  local index = math.floor((percentage / 100) * (#cursor_symbols - 1)) + 1
  return cursor_symbols[index]
end
local config = {
  options = {
    disabled_filetypes = {
      statusline = { "alpha", "dashboard" },
    },
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end
ins_left({
  function()
    return require("battery").get_status_line()
  end,
  color = { fg = "#1affff", bg = "#000000" },
})
ins_left({
  function()
    local mode = vim.fn.mode()
    local mode_symbols = {
      n = " N",
      i = " I",
      v = " V",
      [""] = " V",
      V = " V",
      c = " C",
      no = " N",
      s = " S",
      S = " S",
      [""] = " S",
      ic = " I",
      R = " R",
      Rv = " R",
      cv = " C",
      ce = " C",
      r = " R",
      rm = " R",
      ["r?"] = " R",
      ["!"] = " !",
      t = " T",
    }
    return mode_symbols[mode]
  end,
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1, left = 1 },
})
ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})
ins_left({
  function()
    return "%="
  end,
})
ins_left({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added = { fg = "#81C784" },
    modified = { fg = "#FFB74D" },
    removed = { fg = "#E57373" },
  },
  cond = conditions.hide_in_width,
})
ins_left({
  "branch",
  icon = "",
  color = { fg = "#BA68C8", gui = "bold" },
})
ins_right({
  function()
    local names = {}
    for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    local count = #names
    return "" .. count .. " LSP"
  end,
  icon = "🧠",
  color = { fg = "#EF9A9A", gui = "bold" },
})
ins_right({
  "progress",
  color = {
    fg = "#4DD0E1",
    gui = "bold",
  },
})
ins_right({
  function()
    return cursor_location()
  end,
  color = { fg = "#4DD0E1", gui = "bold" },
})

lualine.setup(config)
