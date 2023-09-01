#!/usr/bin/env bash

# This uploads to https://github.com/keifufu/yass

TOKEN=$(cat $NIXOS_SECRETS/screenshot_token);
HOST=$(cat $NIXOS_SECRETS/screenshot_host);
FILENAME=$(date '+%y-%m-%dT%H-%M-%S.png')

grim -g "$(slurp)" - | convert - -shave 1x1 PNG:- | swappy -f - -o - | curl -X PUT $HOST/upload?filename=$FILENAME -H "Authorization: $TOKEN" -H "Content-Type: application/octet-stream" --data-binary "@-" | wl-copy