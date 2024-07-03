{ pkgs, ...}:
let
  special_app = ./scripts/special_app.sh;
  special_workspace = appName: workspaceName:
    let
      checkCommand = if appName == "telegram-desktop"
                     then "hyprctl cleints | pidof '${appName}'"
                     else "hyprctl clients | grep '${appName}'";
    in
    "${checkCommand} && hyprctl dispatch togglespecialworkspace ${workspaceName} || ${appName}";

  modKey = "ALT";
  superKey = "SUPER";

  mkBind = mod: key: action: "${mod}, ${key}, ${action}";
  mkBindm = mkBind;  # since they're the same in this context
  mkBinde = mkBind;  # since they're the same in this context

  mkWorkspaceBinds = mod: superMod: 
    let
      workspaces = builtins.genList (x: toString (x + 1)) 10;
    in
      builtins.concatLists (map (ws: [
        (mkBind mod (if ws == "10" then "0" else ws) "workspace, ${ws}")
        (mkBind superMod (if ws == "10" then "0" else ws) "movetoworkspace, ${ws}")
      ]) workspaces);

  toggleWlsunset = pkgs.writeShellScript "toggle-wlsunset" ''
    if pgrep -x wlsunset > /dev/null; then
      pkill wlsunset
      notify-send "Night Light" "Disabled"
    else
      wlsunset -T 4001 &
      notify-send "Night Light" "Enabled"
    fi
  '';
in 
{
  wayland.windowManager.hyprland.settings = {

    bind = [
      # core controls
      (mkBind modKey "36" "exec, kitty")
      (mkBind modKey "22" "killactive,")
      (mkBind superKey "47" "exec, ags -t launcher")
      (mkBind superKey "119" "exec, ags -t powermenu")

      # special apps
      (mkBind modKey "Q" "exec, ${special_app} kitty")
      (mkBind modKey "W" "exec, ${special_app} librewolf")
      (mkBind modKey "E" "exec, ${special_app} firefox-nightly")
      (mkBind modKey "R" "exec, ${special_workspace "discord" "discord"}")
      (mkBind modKey "T" "exec, ${special_workspace "telegram-desktop" "telegram"}")

      # apps
      (mkBind superKey "l" "exec, librewolf")
      (mkBind superKey "k" "exec, firefox-nightly")
      (mkBind superKey "j" "exec, google-chrome-stable")

      (mkBind modKey "l" "movefocus, r")
      (mkBind modKey "h" "movefocus, l")
      (mkBind modKey "k" "movefocus, u")
      (mkBind modKey "j" "movefocus, d")

      (mkBind "${modKey} CTRL" "H" "movewindoworgroup, l")
      (mkBind "${modKey} CTRL" "J" "movewindoworgroup, d")
      (mkBind "${modKey} CTRL" "K" "movewindoworgroup, u")
      (mkBind "${modKey} CTRL" "L" "movewindoworgroup, r")

      (mkBind modKey "F" "togglefloating,")
      (mkBind modKey "P" "pseudo,")
      (mkBind modKey "m" "movetoworkspacesilent, special")
      (mkBind modKey "s" "togglespecialworkspace")

      (mkBind modKey "60" "workspace, +1")
      (mkBind modKey "59" "workspace, -1")
    ] 
    ++ (mkWorkspaceBinds modKey superKey)
    ++ [
      (mkBind modKey "mouse_down" "workspace, e+1")
      (mkBind modKey "mouse_up" "workspace, e-1")
    ];

    bindm = [
      (mkBindm modKey "mouse:272" "movewindow")
      (mkBindm modKey "mouse:273" "resizewindow")
    ];

    binde = [
      (mkBinde "" "67" "exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") 
      (mkBinde "" "68" "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
      (mkBinde "" "69" "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
      (mkBinde "" "71" "exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
      (mkBind "" "74" "exec, ${toggleWlsunset}")
      (mkBinde "" "75" "exec, brightnessctl set 5%-")
      (mkBinde "" "76" "exec, brightnessctl set 5%+")
      (mkBinde "${modKey} SHIFT" "H" "resizeactive, -40 0")
      (mkBinde "${modKey} SHIFT" "J" "resizeactive, 0 40")
      (mkBinde "${modKey} SHIFT" "K" "resizeactive, 0 -40")
      (mkBinde "${modKey} SHIFT" "L" "resizeactive, 40 0")
    ];
  };
}
