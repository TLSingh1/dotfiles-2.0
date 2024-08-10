{inputs, ...}: let
  vim-plugins = import ./vim-plugins.nix {inherit inputs;};
  themes = import ./themes.nix {inherit inputs;};
  tools = import ./tools.nix {inherit inputs;};
in [
  inputs.neorg-overlay.overlays.default
  inputs.neovim-nightly-overlay.overlays.default
  vim-plugins
  themes
  tools
]
