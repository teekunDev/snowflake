#!/usr/bin/env bash

if [ $# -ne 2 ]; then
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
    echo "$json_data" | jq -r '"\(.artist + " - " + .title | gsub("&"; "&amp;"))"'
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
