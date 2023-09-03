#!/usr/bin/env bash

if pgrep -x ".wofi-wrapped" >/dev/null; then
  pkill -x .wofi-wrapped
  exit 0
fi

state="$(hyprctl -j clients)"
active_window="$(hyprctl -j activewindow)"

current_addr="$(echo "$active_window" | jq -r '.address')"

window="$(echo "$state" |
  jq -r '.[] | select(.monitor != -1) | "\(.address) \(.workspace.name) \(.title)"' |
  sed "s|$current_addr|focused ->|" |
  sort -r |
  wofi -d --normal-window)"

addr="$(echo "$window" | awk '{print $1}')"
ws="$(echo "$window" | awk '{print $2}')"

if [[ "$addr" =~ focused* ]]; then
  exit 0
fi

fullscreen_on_same_ws="$(echo "$state" | jq -r ".[] | select(.fullscreen == true) | select(.workspace.name == \"$ws\") | .address")"

if [[ "$window" != "" ]]; then
  if [[ "$fullscreen_on_same_ws" == "" ]]; then
    hyprctl dispatch focuswindow address:${addr}
  else
    hyprctl --batch "dispatch focuswindow address:${fullscreen_on_same_ws}; dispatch fullscreen 1; dispatch focuswindow address:${addr}; dispatch fullscreen 1"
  fi
fi