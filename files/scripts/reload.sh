#/usr/bin/env bash

killall .waybar-wrapped
waybar >/dev/null 2>&1 & disown
hyprctl reload
# i dont know if restart had issues or if i
# was dumb and was using reload but whatever this works
# update: this sometimes fucks all up until i replug input devices
# i dont even know...
# systemctl --user stop xremap
# systemctl --user start xremap