{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland.plugins = [
    inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    # inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
  ];
}
