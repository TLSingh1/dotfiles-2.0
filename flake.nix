{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    sops-nix.url = "github:Mic92/sops-nix";
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
  };

  outputs = {
    self, 
    nixpkgs, 
    home-manager, 
    hyprland, 
    nixvim, 
    ags, 
    sops-nix,
    hyprpicker,
    # hyprland-plugins,
    ... 
  }@inputs:
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.default
        {
          nixpkgs.overlays = [ 
            inputs.neorg-overlay.overlays.default
            (final: prev: {
              materia-theme-transparent = prev.callPackage ./packages/materia-theme-transparent.nix {};
              vimPlugins = prev.vimPlugins // {
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

              };
              # winbar = prev.callPackage ./packages/winbar.nix {};
            })
          ];
        }
        sops-nix.nixosModules.sops
        {
          sops = {
            defaultSopsFile = ./secrets/secrets.yaml;
            defaultSopsFormat = "yaml";
            age = {
              sshKeyPaths = [ "/home/tai/.ssh/id_ed25519" ];
              keyFile = "/home/tai/.config/sops/age/keys.txt";
              generateKey = false;
            };
            secrets = {
              git-username = { 
                owner = "sometestservice";
              };
              git-email = { 
                owner = "sometestservice";
              };
              test = { 
                owner = "sometestservice";
              };
            };
          };

        }
      ];
    };
    homeConfigurations."tai@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        hyprland.homeManagerModules.default
        nixvim.homeManagerModules.nixvim
      ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
