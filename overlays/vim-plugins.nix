{inputs, ...}: final: prev: {
  vimPlugins =
    prev.vimPlugins
    // {
      colorful-winsep = prev.vimUtils.buildVimPlugin {
        name = "colorful-winsep";
        src = inputs.colorful-winsep;
      };
      typescript-tools = prev.vimUtils.buildVimPlugin {
        name = "typescript-tools";
        src = inputs.typescript-tools;
      };
      tailwind-tools = prev.vimUtils.buildVimPlugin {
        name = "tailwind-tools";
        src = inputs.tailwind-tools;
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
}