-- NOTE: none-ls diagnostics i think
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = true,
  virtual_lines = {
    only_current_line = true,
    highlight_whole_line = false,
  },
  signs = {
    active = signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  width = 60,
})

vim.diagnostic.open_float = (function(orig)
  return function(opts)
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(opts.bufnr or 0, { lnum = lnum })
    local max_severity = vim.diagnostic.severity.HINT
    for _, d in ipairs(diagnostics) do
      if d.severity < max_severity then
        max_severity = d.severity
      end
    end
    local border_color = ({
      [vim.diagnostic.severity.HINT] = "DiagnosticInfo",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    })[max_severity]
    opts.border = {
      { "╭", border_color },
      { "─", border_color },
      { "╮", border_color },
      { "│", border_color },
      { "╯", border_color },
      { "─", border_color },
      { "╰", border_color },
      { "│", border_color },
    }
    orig(opts)
  end
end)(vim.diagnostic.open_float)


-- NOTE: SignColumn config
-- function get_signs(buf, lnum)
--   local signs = {}
--   local placed_signs = vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs
--   for _, sign in ipairs(placed_signs) do
--     local defined_sign = vim.fn.sign_getdefined(sign.name)[1]
--     if defined_sign then
--       local ret = {
--         name = defined_sign.name,
--         text = defined_sign.text,
--         texthl = defined_sign.texthl,
--         priority = sign.priority
--       }
--       table.insert(signs, ret)
--     end
--   end
--
--   local extmarks = vim.api.nvim_buf_get_extmarks(
--     buf,
--     -1,
--     { lnum - 1, 0 },
--     { lnum - 1, -1 },
--     { details = true, type = "sign" }
--   )
--   for _, extmark in pairs(extmarks) do
--     signs[#signs + 1] = {
--       name = extmark[4].sign_hl_group or "",
--       text = extmark[4].sign_text,
--       texthl = extmark[4].sign_hl_group,
--       priority = extmark[4].priority,
--     }
--   end
--
--   table.sort(signs, function(a, b)
--     return (a.priority or 0) < (b.priority or 0)
--   end)
--
--   return signs
-- end
--
-- function get_mark(buf, lnum)
--   local marks = vim.fn.getmarklist(buf)
--   vim.list_extend(marks, vim.fn.getmarklist())
--   for _, mark in ipairs(marks) do
--     if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
--       return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
--     end
--   end
-- end
--
-- function icon(sign, len)
--   sign = sign or {}
--   len = len or 2
--   local text = vim.fn.strcharpart(sign.text or "", 0, len)
--   text = text .. string.rep(" ", len - vim.fn.strchars(text))
--   return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
-- end
--
-- function statuscolumn()
--   local win = vim.g.statusline_winid
--   local buf = vim.api.nvim_win_get_buf(win)
--   local is_file = vim.bo[buf].buftype == ""
--   local show_signs = vim.wo[win].signcolumn ~= "no"
--
--   local components = { "", "", "" }
--
--   if show_signs then
--     local left, right, fold
--     for _, s in ipairs(get_signs(buf, vim.v.lnum)) do
--       if s.name and s.name:find("GitSign") then
--         right = s
--       else
--         left = s
--       end
--     end
--     if vim.v.virtnum ~= 0 then
--       left = nil
--     end
--     vim.api.nvim_win_call(win, function()
--       if vim.fn.foldclosed(vim.v.lnum) >= 0 then
--         fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
--       end
--     end)
--     components[1] = icon(get_mark(buf, vim.v.lnum) or left)
--     components[3] = is_file and icon(fold or right) or ""
--   end
--
--   local is_num = vim.wo[win].number
--   local is_relnum = vim.wo[win].relativenumber
--
--   if (is_num or is_relnum) then
--     if vim.v.virtnum > 0 then
--       -- This is a wrapped line
--       components[2] = string.rep(" ", 4) -- Adjust the number of spaces as needed
--     elseif vim.v.virtnum == 0 then
--       if vim.v.relnum == 0 then
--         components[2] = is_num and "%l" or "%r"
--       else
--         components[2] = is_relnum and "%r" or "%l"
--       end
--       components[2] = "%=" .. components[2] .. " "
--     else
--       -- This handles the case of 'diff' mode
--       components[2] = "%="
--     end
--   end
--
--   return table.concat(components, "")
-- end
--
-- -- Set the statuscolumn option
-- vim.opt.statuscolumn = [[%!v:lua.statuscolumn()]]
