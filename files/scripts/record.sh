#!/usr/bin/env bash

TOKEN=$(cat $NIXOS_SECRETS/yass_token);
HOST=$(cat $NIXOS_SECRETS/yass_host);
FILENAME=$(date '+%y-%m-%dT%H-%M-%S.mp4')
TMP_PATH=/tmp/recording.mp4

if [ "$1" == "status" ]; then
  if pgrep -f "wf-recorder" >/dev/null; then
    echo "󰑊 Recording"
  fi
  exit 0
fi

if pgrep -f "wf-recorder" >/dev/null; then
  pkill -SIGINT -f "wf-recorder"
  sleep 3
  curl -X PUT $HOST/upload?filename=$FILENAME -H "Authorization: $TOKEN" -H "Content-Type: application/octet-stream" --data-binary "@$TMP_PATH" | sed 's/$/?raw/' | wl-copy
  notify-send -t 3000 "Finished uploading video"
elif [ "$1" == "--audio" ]; then
  wf-recorder -t --audio="$(pactl get-default-sink).monitor" -g "$(slurp)" -f $TMP_PATH <<<Y
else
  wf-recorder -t -g "$(slurp)" -f $TMP_PATH <<<Y
fi