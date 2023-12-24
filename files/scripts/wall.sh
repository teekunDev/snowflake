#!/usr/bin/env bash

if [[ $(pgrep -c -f "wall.sh") -gt 1 ]]; then
  pkill -f wall.sh
  pkill -x .wofi-wrapped
  exit 0
fi


files=("$NIXOS_WALLDIR"/*)
formatted_files=()
for file in "${files[@]}"; do
  filename=$(basename "$file")
  formatted_files+=("img:$file:text:$filename")
done
selected=$(printf "%s\n" "${formatted_files[@]}" | wofi --dmenu --normal-window)
image=$(basename "$(echo "$selected" | cut -d':' -f4)")
if [[ -n "$image" ]]; then
  opacity=$(echo -e "0%\n5%\n10%\n15%\n20%\n25%\n30%\n35%\n40%\n45%\n50%" | wofi --dmenu --normal-window)
  opacity=$(echo "$opacity" | sed 's/%//')
  opacity_fraction=$((opacity * 100 / 10000))

  input="$NIXOS_WALLDIR/$image"
  output="$HOME/wall.png"

  convert -size $(identify -format "%wx%h" "$input") xc:black -fill "rgba(0,0,0,$opacity_fraction)" -draw "rectangle 0,0 $(identify -format "%w,%h" "$input")" overlay.png
  composite -dissolve $opacity% -gravity center overlay.png "$input" "$output"
  rm overlay.png

  pkill -x hyprpaper
  sleep 1
  hyprpaper & disown
fi

