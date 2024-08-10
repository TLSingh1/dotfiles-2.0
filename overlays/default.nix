{inputs}: {
  nixpkgs.overlays = [
    inputs.neorg-overlay.overlays.default
    inputs.neovim-nightly-overlay.overlays.default
    (final: prev: {
      tree-sitter-cli = final.callPackage ./packages/tree-sitter-cli.nix {};
      # msi-perkeyrgb = final.callPackage ./packages/msi-perkeyrgb.nix {};
      materia-theme-transparent = prev.callPackage ./packages/materia-theme-transparent.nix {};
      neon-town-sddm = prev.callPackage ./packages/neon-town-sddm.nix {};
      vimPlugins =
        prev.vimPlugins
        // {
          winbar-nvim = prev.vimUtils.buildVimPlugin {
            name = "winbar-nvim";
            src = inputs.winbar-nvim;
          };
          colorful-winsep = prev.vimUtils.buildVimPlugin {
            name = "colorful-winsep";
            src = inputs.colorful-winsep;
          };
          incline = prev.vimUtils.buildVimPlugin {
            name = "incline";
            src = inputs.incline;
          };
          markdown-nvim = prev.vimUtils.buildVimPlugin {
            name = "markdown-nvim";
            src = inputs.markdown-nvim;
          };
          typescript-tools = prev.vimUtils.buildVimPlugin {
            name = "typescript-tools";
            src = inputs.typescript-tools;
          };
          tailwind-tools = prev.vimUtils.buildVimPlugin {
            name = "tailwind-tools";
            src = inputs.tailwind-tools;
          };
          yazi-nvim = prev.vimUtils.buildVimPlugin {
            name = "yazi-nvim";
            src = inputs.yazi-nvim;
          };
          gen-nvim = prev.vimUtils.buildVimPlugin {
            name = "gen-nvim";
            src = inputs.gen-nvim;
          };
          neorg-templates = prev.vimUtils.buildVimPlugin {
            name = "neorg-templates";
            src = inputs.neorg-templates;
          };
          claude-nvim = prev.vimUtils.buildVimPlugin {
            name = "claude-nvim";
            src = inputs.claude-nvim;
          };
          nerdy-nvim = prev.vimUtils.buildVimPlugin {
            name = "nerdy-nvim";
            src = inputs.nerdy-nvim;
          };
          colorizer-nvim = prev.vimUtils.buildVimPlugin {
            name = "colorizer-nvim";
            src = inputs.colorizer-nvim;
          };
          helpview-nvim = prev.vimUtils.buildVimPlugin {
            name = "helpview-nvim";
            src = inputs.helpview-nvim;
          };
          markview-nvim = prev.vimUtils.buildVimPlugin {
            name = "markview-nvim";
            src = inputs.markview-nvim;
          };
        };
    })
  ];
}
