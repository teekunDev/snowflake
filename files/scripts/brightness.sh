#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Usage: brightness.sh <brightness>"
  exit 1
fi

ddcutil setvcp 10 $1 --display=1
ddcutil setvcp 10 $1 --display=2
ddcutil setvcp 10 $1 --display=3