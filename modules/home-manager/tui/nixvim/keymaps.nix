{
  programs.nixvim.keymaps = [
    {
      action = "<ESC>";
      key = "jk";
      options = { silent = true; };
      mode = "i";
    }
    {
      action = ":w <CR>";
      key = "<leader>w";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":q <CR>";
      key = "<leader>q";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":qa <CR>";
      key = "<leader><leader>q";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":qa! <CR>";
      key = "<leader>QA";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":IncRename ";
      key = "<leader>rn";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "p:let @+=@0<CR>";
      key = "p";
      options = { silent = true; };
      mode = "x";
    }
    {
      action = ":SessionSave <CR>";
      key = "<leader>S";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":vs <CR>";
      key = "<leader>d";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":split <CR>";
      key = "<leader>s";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":bdelete <cr>";
      key = "<c-n>";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "<C-w>h";
      key = "<leader>h";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "<C-w>j";
      key = "<leader>j";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "<C-w>k";
      key = "<leader>k";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "<C-w>l";
      key = "<leader>l";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":";
      key = "<leader>;";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":bnext <CR>";
      key = "<S-l>";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":bprevious <CR>";
      key = "<S-h>";
      options = { silent = true; };
      mode = "n";
    }
    {
      # action = ":Neotree float reveal <CR>";
      action = "<cmd>lua require('yazi').yazi() <CR>";
      key = ";";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":Neotree float reveal <CR>";
      key = ":";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":Navbuddy <CR>";
      key = "'\'";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>";
      key = "<leader>f";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = ":Telescope diagnostics <CR>";
      key = "<leader>td";
      options = { silent = true; };
      mode = "n";
    }
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>g";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "f";
      action = ":HopWord <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "F";
      action = ":HopLine <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "<C-f>";
      action = ":HopChar1 <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "<C-h>";
      action = ":SmartResizeLeft <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "<C-l>";
      action = ":SmartResizeRight <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "<C-j>";
      action = ":SmartResizeDown <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "<C-k>";
      action = ":SmartResizeUp <CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "gl";
      action = ":lua vim.diagnostic.open_float({ border = 'rounded' })<CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      options = { silent = true; };
      mode = "n";
    }
    {
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      options = { silent = true; };
      mode = "n";
    }
  ];
}

