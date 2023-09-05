#!/usr/bin/env bash

if pgrep -x ".wofi-wrapped" >/dev/null; then
  pkill -x .wofi-wrapped
else
  wofi --show drun --normal-window --columns 2
fi