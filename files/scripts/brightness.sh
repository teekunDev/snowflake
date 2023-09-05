#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
  echo "Usage: brightness.sh <get|set> [(+|-)brightness]"
  exit 1
fi

operation="$1"

if [ "$operation" == "get" ]; then
  current_brightness=$(cat ~/.brightness 2>/dev/null || echo "0")
  if [ "$#" -eq 2 ] && [ "$2" == "--json" ]; then
    echo "{\"percentage\": $current_brightness}"
  else
    echo "$current_brightness"
  fi
elif [ "$operation" == "set" ]; then
  if [ "$#" -ne 2 ]; then
    echo "Usage: brightness.sh <get|set> [(+|-)brightness]"
    exit 1
  fi

  input_brightness="$2"
  if [[ "$input_brightness" =~ ^[+-][0-9]+$ ]]; then
    current_brightness=$(cat ~/.brightness 2>/dev/null || echo "0")
    new_brightness=$((current_brightness + input_brightness))

    new_brightness=$((new_brightness < 0 ? 0 : new_brightness))
    new_brightness=$((new_brightness > 100 ? 100 : new_brightness))

    brightness="$new_brightness"
  else
    brightness="$input_brightness"
  fi

  echo "$brightness" > ~/.brightness
  kill -9 $(pgrep -f ${BASH_SOURCE[0]} | grep -v $$) >/dev/null 2>&1

  # Wait for 1 second to not spam ddcutil when scrolling waybar brightness
  sleep 1

  ddcutil setvcp 10 "$brightness" --display 1
  ddcutil setvcp 10 "$brightness" --display 2
  ddcutil setvcp 10 "$brightness" --display 3
else
  echo "Usage: brightness.sh <get|set> [(+|-)brightness]"
  exit 1
fi