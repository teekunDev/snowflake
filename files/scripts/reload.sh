#/usr/bin/env bash

killall .waybar-wrapped
waybar >/dev/null 2>&1 & disown
hyprctl reload