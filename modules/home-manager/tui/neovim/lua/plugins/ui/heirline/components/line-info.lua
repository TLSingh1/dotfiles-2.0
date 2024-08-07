local LineInfo = {
  provider = function()
    local line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local col = vim.fn.virtcol('.')
    -- return string.format("%4d:%-3d| %d", line, total_lines, col)
    return string.format("%d : %d | %d", col, line, total_lines)
  end,
  hl = { fg = "#94e2d6", bold = true },
}
return LineInfo
