{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    ags.url = "github:Aylur/ags";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winbar-nvim = {
      url = "github:Ramilito/winbar.nvim";
      flake = false;
    };
    colorful-winsep = {
      url = "github:nvim-zh/colorful-winsep.nvim";
      flake = false;
    };
    incline = {
      url = "github:b0o/incline.nvim";
      flake = false;
    };
    markdown-nvim = {
      url = "github:MeanderingProgrammer/markdown.nvim";
      flake = false;
    };
    typescript-tools = {
      url = "github:pmizio/typescript-tools.nvim";
      flake = false;
    };
    tailwind-tools = {
      url = "github:luckasRanarison/tailwind-tools.nvim";
      flake = false;
    };
    yazi-nvim = {
      url = "github:mikavilpas/yazi.nvim";
      flake = false;
    };
    gen-nvim = {
      url = "github:David-Kunz/gen.nvim";
      flake = false;
    };
    neorg-templates = {
      url = "github:pysan3/neorg-templates";
      flake = false;
    };
    claude-nvim = {
      url = "github:pasky/claude.vim";
      flake = false;
    };
    nerdy-nvim = {
      url = "github:2KAbhishek/nerdy.nvim";
      flake = false;
    };
    colorizer-nvim = {
      url = "github:norcalli/nvim-colorizer.lua";
      flake = false;
    };
    eldritch-nvim = {
      url = "github:eldritch-theme/eldritch.nvim";
      flake = false;
    };
  };

  outputs = {
    # self,
    nixpkgs,
    home-manager,
    hyprland,
    # nixvim,
    # ags,
    # sops-nix,
    # hyprpicker,
    # hyprland-plugins,
    ...
  } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.default
        {
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
                  eldritch-nvim = prev.vimUtils.buildVimPlugin {
                    name = "eldritch-nvim";
                    src = inputs.eldritch-nvim;
                  };
                };
            })
          ];
        }
      ];
    };
    homeConfigurations."tai@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        hyprland.homeManagerModules.default
        # nixvim.homeManagerModules.nixvim
      ];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
