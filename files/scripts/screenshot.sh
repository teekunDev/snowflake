#!/usr/bin/env bash

TOKEN=$(cat $NIXOS_SECRETS/yass_token);
HOST=$(cat $NIXOS_SECRETS/yass_host);
FILENAME=$(date '+%y-%m-%dT%H-%M-%S.png')

# TODO: freeze screen

region="$(slurp)"
if [[ -n "$region" ]]; then
  grim -g "$region" - | convert - -shave 1x1 PNG:- | swappy -f - -o - | curl -X PUT $HOST/upload?filename=$FILENAME -H "Authorization: $TOKEN" -H "Content-Type: application/octet-stream" --data-binary "@-" | wl-copy
  notify-send -t 3000 "Uploaded screenshot"
fi