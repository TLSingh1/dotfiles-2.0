{pkgs, ...}: {
  wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprexpo
    pkgs.hyprlandPlugins.hyprtrails
  ];

  wayland.windowManager.hyprland.settings.plugin = {
    hyprexpo = {
      columns = 3;
      gap_size = 5;
      bg_col = "rgb(111111)";
      workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1

      enable_gesture = true; # laptop touchpad
      gesture_fingers = 3;
      gesture_distance = 200; # how far is the "max"
      gesture_positive = true; # positive = swipe down. Negative = swipe up.
    };
    hyprtrails = {
      color = "rgba(aba3dbff)";
    };
    hyprwinwrap = {
      class = "kitty-bg";
    };
  };
}
