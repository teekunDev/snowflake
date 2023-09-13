#!/usr/bin/env bash

# could use wpctl here

if [ "$#" -lt 1 ]; then
  echo "Usage: audio.sh <sink|source> <get|set|toggle-mute> [(+|-)volume]"
  exit 1
fi

get_volume() {
  if [[ "$source" == "sink" ]]; then
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2;}')
    current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
    if [ "$muted" == "yes" ]; then
      current_volume=0
    fi
  elif [[ "$source" == "source" ]]; then
    muted=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2;}')
    current_volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | tr -d '%')
    if [ "$muted" == "yes" ]; then
      current_volume=0
    fi
  else
    echo "Usage: audio.sh <sink|source> <get|set|toggle-mute> [(+|-)volume]"
    exit 1
  fi
}

set_volume() {
  input_volume="$1"
  if [[ "$input_volume" =~ ^[+-][0-9]+$ ]]; then
    get_volume
    new_volume=$((current_volume + input_volume))
    new_volume=$((new_volume < 0 ? 0 : new_volume))
    new_volume=$((new_volume > 100 ? 100 : new_volume))
    vol=$new_volume
  else
    input_volume=$((input_volume < 0 ? 0 : input_volume))
    input_volume=$((input_volume > 100 ? 100 : input_volume))
    vol=$input_volume
  fi

  echo $vol

  if [[ "$source" == "sink" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ $vol%
  elif [[ "$source" == "source" ]]; then
    pactl set-source-volume @DEFAULT_SOURCE@ $vol%
  else
    echo "Usage: audio.sh <sink|source> <get|set|toggle-mute> [(+|-)volume]"
    exit 1
  fi
}

play_ping() {
  if [[ "$1" == "--ping" ]]; then
    if [[ "$muted" == "yes" ]]; then
      paplay $NIXOS_FILES/sound/unmute.mp3
    else
      paplay $NIXOS_FILES/sound/mute.mp3
    fi
  fi
}

toggle_mute() {
  if [[ "$source" == "sink" ]]; then
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2;}')
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    play_ping $1
  elif [[ "$source" == "source" ]]; then
    muted=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2;}')
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    play_ping $1
  else
    echo "Usage: audio.sh <sink|source> <get|set|toggle-mute> [(+|-)volume]"
    exit 1
  fi
}

source="$1"
operation="$2"
if [ "$operation" == "get" ]; then
  get_volume
  if [[ "$3" == "--waybar" ]]; then
    if [[ $current_volume == 0 ]]; then
      icon=""
      class="off"
    else
      icon=""
      class="on"
    fi
    printf '{"text": "%s", "class": "%s"}\n' "$icon" "$class"
  else
    echo "$current_volume"
  fi
elif [ "$operation" == "set" ]; then
  if [ "$#" -ne 3 ]; then
    echo "Usage: audio.sh <sink|source> <get|set|toggle-mute> [(+|-)volume]"
    exit 1
  fi
  set_volume "$3"
elif [ "$operation" == "toggle-mute" ]; then
  toggle_mute "$3"
else
  echo "Usage: audio.sh <sink|source> <get|set|toggle-mute> [(+|-)volume]"
  exit 1
fi