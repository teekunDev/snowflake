#!/usr/bin/env bash

TOKEN=$(cat $NIXOS_SECRETS/yass_token);
HOST=$(cat $NIXOS_SECRETS/yass_host);
FILENAME=$(date '+%y-%m-%dT%H-%M-%S.mp4')
TMPVIDEO="/tmp/recording.mp4" # has to be static and not mktemp
TMPIMG=$(mktemp --suffix recording.png)

if [ "$1" == "status" ]; then
  if pgrep -f "wf-recorder" >/dev/null; then
    echo "󰑊 Recording"
  fi
  exit 0
fi

if pgrep -f "wf-recorder" >/dev/null; then
  pkill -SIGINT -f "wf-recorder"
  
  id=$(notify-send -t 999999 "Uploading video..." --print-id)

  while pgrep -f wf-recorder >/dev/null; do
    sleep 0.1
  done

  RESPONSE=$(curl -s -w "%{http_code}" -X PUT $HOST/upload?filename=$FILENAME -H "Authorization: $TOKEN" -H "Content-Type: application/octet-stream" --data-binary "@$TMPVIDEO")

  HTTP_STATUS="${RESPONSE: -3}"
  BODY="${RESPONSE%${HTTP_STATUS}}"

  ffmpeg -y -i "$TMPVIDEO" -ss 00:00:01 -vframes 1 "$TMPIMG"

  if [[ "$HTTP_STATUS" -ge 200 && "$HTTP_STATUS" -lt 300 ]]; then
    wl-copy "$BODY?raw"
    notify-send -t 5000 -r $id -i $TMPIMG "Done uploading"
  else
    notify-send -t 5000 -r $id -i $TMPIMG "Failed to upload: $HTTP_STATUS"
  fi
elif [ "$1" == "--audio" ]; then
  wf-recorder -x yuv420p --audio="$(pactl get-default-sink).monitor" -g "$(slurp -b "#cad3f533" -c "#ffffffff" -d)" -f $TMPVIDEO <<<Y
else
  # "-x yuv420p" see https://github.com/ammen99/wf-recorder/issues/218#issuecomment-1710702237
  wf-recorder -x yuv420p -g "$(slurp -b "#cad3f533" -c "#ffffffff" -d)" -f $TMPVIDEO <<<Y
fi