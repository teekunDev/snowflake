#!/usr/bin/env bash

if [ $# -lt 2 ]; then
  echo "Usage: wnpctl.sh (get|execute) (key|command)"
  exit 1
fi

exec 3<>/dev/tcp/127.0.0.1/5467

if [[ "$1" == "get" ]]; then 
  echo -n "NOOP" >&3
  key="$2"
  json_data=$(cat <&3)
  if [[ "$key" == "all" ]]; then
    echo "$json_data"
  elif [[ "$key" == "formatted" ]]; then
    # sed replaces & with &amp and escapes quotes
    artist=$(echo "$json_data" | jq -r ".artist" | sed 's/&/\&amp;/g; s/\"/\\"/g')
    title=$(echo "$json_data" | jq -r ".title" | sed 's/&/\&amp;/g; s/\"/\\"/g')

    if [ -z "$title" ]; then
      formatted="No media found"
    else
      # 󰎈
      formatted="$artist - $title"
    fi

    if [ "$#" -eq 3 ] && [ "$3" == "--json" ]; then
      tooltip="Left-click: Previous Song\nMidde click: Play/Pause\nRight-click: Next Song\nScroll: Change Volume"
      echo "{\"text\": \"$formatted\",\"tooltip\": \"$tooltip\"}"
    else
      echo $formatted
    fi
  else
    echo "$json_data" | jq -r ".$key"
  fi
elif [[ "$1" == "execute" ]]; then
  echo -n "$2" >&3
else
  echo "Usage: wnpctl.sh (get|execute) (key|command)"
  exit 1
fi

exec 3<&-
exec 3>&-
