{
  programs.nixvim.plugins.obsidian = {
    enable = false;
    settings = {
      picker.name = "telescope.nvim";
      # ui.enable = false;
      completion.nvim_cmp = true;
      workspaces = [
        { 
          name = "brain"; 
          path = "~/Brain";
        }
      ];
    };
  };
}
