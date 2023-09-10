#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "Usage: vpn.sh (connect|disconnect|status) [--waybar]"
  exit 1
fi

if [[ "$1" == "connect" ]]; then
  mullvad connect
elif [[ "$1" == "disconnect" ]]; then
  mullvad disconnect
elif [[ "$1" == "status" ]]; then
  if [[ "$2" == "--waybar" ]]; then
    status=$(mullvad status)
    status_short=$(mullvad status | awk '{print $1;}') 
    if [[ "$status_short" == "Connected" ]]; then
      icon=""
      class=on
    else
      icon=""
      class=off
    fi
    printf '{"text": "%s", "class": "%s", "tooltip": "%s"}\n' "$icon" "$class" "$status"
  else
    mullvad status
    fi
  else
  echo "Usage: vpn.sh (connect|disconnect|status) [--waybar]"
  exit 1
fi