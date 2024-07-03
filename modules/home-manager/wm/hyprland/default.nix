{ inputs, pkgs, ...}:
{
  imports = [
    ./animations.nix
    ./binds.nix
    ./decoration.nix
    ./execs.nix
    ./general.nix
    ./windowrules.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
    settings = {
      input = {
        touchpad = {
          natural_scroll = true;
          middle_button_emulation = true;
          tap-to-click = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
    };
  };
}