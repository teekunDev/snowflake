#!/usr/bin/env bash

TOKEN=$(cat $NIXOS_SECRETS/yass_token);
HOST=$(cat $NIXOS_SECRETS/yass_host);
PPMIMG=$(mktemp --suffix ss.ppm)
PNGIMG=$(mktemp --suffix ss.png)
FILENAME=$(date '+%y-%m-%dT%H-%M-%S.png')
FEHCLASS="screenshot-overlay";

if [[ $(pgrep -c -f "screenshot.sh") -gt 1 ]]; then
  exit 0
fi

grim -c -t ppm "$PPMIMG"
feh --class "$FEHCLASS" "$PPMIMG" & # hyprland handles positioning and sizing feh
sleep 0.1 # wait for feh to open :/
region="$(slurp -f %w:%h:%x:%y -d)" # TODO: maybe make the slurp colors nicer (slurp -help)
pkill -f "$FEHCLASS"
if [[ -n "$region" ]]; then
  ffmpeg -loglevel warning -i "$PPMIMG" -vf "crop=$region" -y \
    -c:v png -f image2pipe -pred 2 -compression_level 1 -  \
    | swappy -f - -o - > $PNGIMG

  id=$(notify-send -t 999999 "Uploading screenshot..." --print-id)

  RESPONSE=$(curl -s -w "%{http_code}" -X PUT $HOST/upload?filename=$FILENAME -H "Authorization: $TOKEN" -H "Content-Type: application/octet-stream" --data-binary "@$PNGIMG")

  HTTP_STATUS="${RESPONSE: -3}"
  BODY="${RESPONSE%${HTTP_STATUS}}"

  if [[ "$HTTP_STATUS" -ge 200 && "$HTTP_STATUS" -lt 300 ]]; then
    wl-copy "$BODY"
    notify-send -t 5000 -r $id -i $PNGIMG "Done uploading"
  else
    notify-send -t 5000 -r $id -i $PNGIMG "Failed to upload: $HTTP_STATUS"
  fi
fi