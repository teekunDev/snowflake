#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <brightness up|brightness down>"
  exit 1
fi

if [ "$1" == "up" ]; then
  ddcutil setvcp 10 100 --display=1
  ddcutil setvcp 10 100 --display=2
  ddcutil setvcp 10 100 --display=3
elif [ "$1" == "down" ]; then
  ddcutil setvcp 10 0 --display=1
  ddcutil setvcp 10 0 --display=2
  ddcutil setvcp 10 0 --display=3
else
  echo "Usage: $0 <brightness up|brightness down>"
  exit 1
fi
