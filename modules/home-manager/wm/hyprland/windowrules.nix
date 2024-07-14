{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opacity 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
      "maxsize 1 1,class:^(xwaylandvideobridge)$"
      "noblur,class:^(xwaylandvideobridge)$"

      # Qalculate-gtk
      "float,class:(qalculate-gtk)"
      "workspace special:calculator,class:(qalculate-gtk)"

      # Kitty
      "float,noblur,class:(kitty-bg)"
      # "noblur,float,noinitialfocus,pin,fullscreen,class:(kitty-bg)"
      # "float,title:(fly_is_kitty)"
      # "size 600 400,title:(fly_is_kitty)"
      # "workspace special:terminal, title:(fly_is_kitty)"

      # Discord
      "float,class:(discord)"
      "size 600 400,class:(discord)"
      "move 26.5% 25%,class:(discord)"
      "workspace special:discord, class:(discord)"

      # Telegram
      "float,class:(org.telegram.desktop)"
      "size 800 400,class:(org.telegram.desktop)"
      "center,class:(org.telegram.desktop)"
      "workspace special:telegram, class:(org.telegram.desktop)"


      # Librewolf
      "opacity 0.85 0.85,class:(librewolf)"

    ];
  };
}
