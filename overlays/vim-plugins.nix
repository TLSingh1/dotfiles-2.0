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
      resession-nvim = prev.vimUtils.buildVimPlugin {
        name = "resession-nvim";
        src = inputs.resession-nvim;
      };
      nuicomponents-nvim = prev.vimUtils.buildVimPlugin {
        name = "nuicomponents-nvim";
        src = inputs.nuicomponents-nvim;
      };
      avante-nvim = prev.vimUtils.buildVimPlugin {
        name = "avante-nvim";
        src = inputs.avante-nvim;
      };
      mini-misc = prev.vimUtils.buildVimPlugin {
        name = "mini-misc";
        src = inputs.mini-misc;
      };
      render-markdown = prev.vimUtils.buildVimPlugin {
        name = "render-markdown";
        src = inputs.render-markdown;
      };
    };
}
