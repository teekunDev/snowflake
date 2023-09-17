#!/usr/bin/env bash

TOKEN=$(cat $NIXOS_SECRETS/yass_token);
HOST=$(cat $NIXOS_SECRETS/yass_host);
TMPFILE=/tmp/ss.png
FILENAME=$(date '+%y-%m-%dT%H-%M-%S.png')

# TODO: freeze screen

region="$(slurp)"
if [[ -n "$region" ]]; then
  grim -g "$region" - | convert - -shave 1x1 PNG:- | swappy -f - -o - > $TMPFILE
  id=$(notify-send -t 999999 "Uploading screenshot..." --print-id)

  RESPONSE=$(curl -s -w "%{http_code}" -X PUT $HOST/upload?filename=$FILENAME -H "Authorization: $TOKEN" -H "Content-Type: application/octet-stream" --data-binary "@$TMPFILE")

  HTTP_STATUS="${RESPONSE: -3}"
  BODY="${RESPONSE%${HTTP_STATUS}}"

  if [[ "$HTTP_STATUS" -ge 200 && "$HTTP_STATUS" -lt 300 ]]; then
    wl-copy $BODY
    notify-send -t 5000 -r $id -i $TMPFILE "Done uploading"
  else
    notify-send -t 5000 -r $id -i $TMPFILE "Failed to upload: $HTTP_STATUS"
  fi
fi