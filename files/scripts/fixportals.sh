#!/usr/bin/env bash

systemctl --user stop xdg-desktop-portal-hyprland.service
sleep 1
systemctl --user stop xdg-desktop-portal.service
sleep 1
systemctl --user start xdg-desktop-portal-hyprland.service
sleep 1
systemctl --user start xdg-desktop-portal.service