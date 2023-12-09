#!/usr/bin/env bash

if [[ $(pgrep -c -f "wall.sh") -gt 1 ]]; then
  pkill -f wall.sh
  pkill -x .wofi-wrapped
  exit 0
fi

# TODO: some way to see the images im selecting

# script to preprocess wallpapers that are too big to be smaller?

image=$(find "$NIXOS_FILES/wall" -type f -exec basename {} \; | wofi -d --normal-window)
if [[ -n "$image" ]]; then
  opacity=$(echo -e "0%\n5%\n10%\n15%\n20%\n25%\n30%\n35%\n40%\n45%\n50%" | wofi -d --normal-window)
  opacity=$(echo "$opacity" | sed 's/%//')
  opacity_fraction=$((opacity * 100 / 10000))

  input="$NIXOS_FILES/wall/$image"
  output="$NIXOS_FILES/wall.png"

  convert -size $(identify -format "%wx%h" "$input") xc:black -fill "rgba(0,0,0,$opacity_fraction)" -draw "rectangle 0,0 $(identify -format "%w,%h" "$input")" overlay.png
  composite -dissolve $opacity% -gravity center overlay.png "$input" "$output"
  rm overlay.png

  pkill -x hyprpaper
  sleep 1
  hyprpaper & disown
fi

