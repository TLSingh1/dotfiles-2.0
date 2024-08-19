{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
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
    colorful-winsep = {
      url = "github:nvim-zh/colorful-winsep.nvim";
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
    helpview-nvim = {
      url = "github:OXY2DEV/helpview.nvim";
      flake = false;
    };
    markview-nvim = {
      url = "github:OXY2DEV/markview.nvim";
      flake = false;
    };
    resession-nvim = {
      url = "github:stevearc/resession.nvim";
      flake = false;
    };
    time-tracker-nvim = {
      url = "github:3rd/time-tracker.nvim";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.default
        {
          nixpkgs.overlays = import ./overlays/default.nix {inherit inputs;};
        }
      ];
    };
    homeConfigurations."tai@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        hyprland.homeManagerModules.default
      ];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
