#!/usr/bin/env bash

APP="$1"
WORKSPACE="special:$APP"

get_window_size() {
  case "$APP" in
    "kitty") echo "600 400" ;;
    "discord") echo "600 400" ;;
    "librewolf") echo "800 500" ;;
    "firefox-nightly") echo "800 600" ;;
    "telegram-desktop") echo "800 500" ;;
    *) echo "600 400" ;;
  esac
}
WINDOW_SIZE=$(get_window_size)

if hyprctl clients -j | jq -e ".[] | select(.class == \"$APP\" and .workspace.name == \"$WORKSPACE\")" > /dev/null; then
    hyprctl dispatch togglespecialworkspace "$APP"
else
    hyprctl dispatch exec "[workspace $WORKSPACE; float; size $WINDOW_SIZE; center] $APP"
fi
