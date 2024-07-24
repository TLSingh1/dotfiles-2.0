
{
  programs.nixvim.plugins.nvim-ufo = {
    enable = true;
    enableGetFoldVirtText = true;
    foldVirtTextHandler = ''
      function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('║ %d lines ║   '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        local lines = vim.api.nvim_buf_get_lines(0, lnum - 1, endLnum, false)
        local preview = lines[1] or ""
        
        -- Truncate the preview if it's too long
        if #preview > targetWidth then
          preview = preview:sub(1, targetWidth - 3) .. "..."
        end
        
        table.insert(newVirtText, {preview, "Normal"})
        curWidth = vim.fn.strdisplaywidth(preview)
        
        if curWidth < targetWidth then
          suffix = (' '):rep(targetWidth - curWidth) .. suffix
        end
        
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end
    '';
  };
}
