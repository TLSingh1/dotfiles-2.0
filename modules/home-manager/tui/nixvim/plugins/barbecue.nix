{
  programs.nixvim.plugins.barbecue = {
    enable = true;
    attachNavic = true;
    excludeFiletypes = [
      "toggleterm"
      "dashboard"
    ];
    modified = ''
      function(bufnr)
      	return vim.bo[bufnr].modified
      end
    '';
    showBasename = true;
    showDirname = true;
    showModified = true;
    showNavic = false;
  };
}
