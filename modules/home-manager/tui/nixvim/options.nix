{
  programs.nixvim = {
    globals.mapleader = " ";
    globalOpts = {
      backup = false;
      clipboard = "unnamedplus";
      cmdheight = 1;
      completeopt = [ "menuone" "noselect" ];
      conceallevel = 3;
      fileencoding = "utf-8";
      hlsearch = false;
      ignorecase = true;
      mouse = "a";
      pumheight = 10;
      showmode = false;
      showtabline = 2;
      smartcase = true;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      termguicolors = true;
      timeoutlen = 1000;
      undofile = true;
      updatetime = 300;
      writebackup = false;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      cursorline = true;
      number = true;
      relativenumber = true;
      numberwidth = 4;
      signcolumn = "no";
      wrap = true;
      scrolloff = 8;
# spell = true;
# spellsuggest = "10";
      laststatus = 3;
      breakindent = true;
      /* breakindentopt = "shift:2,min:40,sbr"; */
      linebreak = true;
      winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow";
# foldcolumn = "1";
# foldlevel = 99;
# foldenable = true;
# foldlevelstart = 99;
# winbar = " ";
    };
  };
}

