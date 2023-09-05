#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
  echo "Usage: volume.sh <get|set|toggle-mute> [(+|-)volume]"
  exit 1
fi

get_volume() {
  current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
}

set_volume() {
  input_volume="$1"
  if [[ "$input_volume" =~ ^[+-][0-9]+$ ]]; then
    get_volume
    new_volume=$((current_volume + input_volume))

    new_volume=$((new_volume < 0 ? 0 : new_volume))
    new_volume=$((new_volume > 100 ? 100 : new_volume))

    pactl set-sink-volume @DEFAULT_SINK@ $new_volume%
  else
    pactl set-sink-volume @DEFAULT_SINK@ $input_volume%
  fi
}

toggle_mute() {
  pactl set-sink-mute @DEFAULT_SINK@ toggle
}

operation="$1"
if [ "$operation" == "get" ]; then
  get_volume
  echo "$current_volume"
elif [ "$operation" == "set" ]; then
  if [ "$#" -ne 2 ]; then
    echo "Usage: volume.sh <get|set|toggle-mute> [(+|-)volume]"
    exit 1
  fi
  set_volume "$2"
elif [ "$operation" == "toggle-mute" ]; then
  toggle_mute
else
  echo "Usage: volume.sh <get|set|toggle-mute> [(+|-)volume]"
  exit 1
fi