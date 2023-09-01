#!/usr/bin/env bash

hyprctl dispatch submap none

random_chars=$(head /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 7)

wtype "$random_chars"

hyprctl dispatch submap reset