{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      picker.name = "telescope.nvim";
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
