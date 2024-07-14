{
  imports = [
    ./animations.nix
    ./binds.nix
    ./decoration.nix
    ./execs.nix
    ./general.nix
    ./plugins.nix
    ./windowrules.nix
    ./workspacerules.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # plugins = [
    #   pkgs.hyprlandPlugins.hyprexpo
    #   pkgs.hyprlandPlugins.hyprtrails
    #   # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    # ];
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
