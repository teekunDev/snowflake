#/usr/bin/env bash

killall .waybar-wrapped
waybar >/dev/null 2>&1 & disown
hyprctl reload
systemctl --user stop xremap
systemctl --user start xremap