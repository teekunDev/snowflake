#!/usr/bin/env bash

ssh_user="keifufu"
ssh_host="192.168.2.111"
hostname=$(hostname)
excluded_server=(".Trash-1000" "lost+found" "/games" "/torrents")
excluded_desktop=(".Trash-1000" "lost+found" "/kvm" "/SteamLibrary")
date=$(date +"%Y-%m-%d")

read -p "Are you sure you want to run this (y/n)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]
then
  exit 1
fi

if [ -d "$1" ] && [ -d "$1/backups" ]; then
  backup_folder="$1/backups/$date"

  # Back up servers /stuff
  mkdir -p "$backup_folder/server"
  rsync -av --filter=':- .gitignore' "${excluded_server[@]/#/--exclude=}" "$ssh_user@$ssh_host:/stuff/" "$backup_folder/server"

  # Back up current hosts /stuff
  if [[ "$hostname" == "desktop" ]]; then
    mkdir -p "$backup_folder/$hostname"
    rsync -av --filter=':- .gitignore' "${excluded_desktop[@]/#/--exclude=}" "/stuff/" "$backup_folder/$hostname"
  fi # laptop here if needed
  
  echo "Backup completed successfully to $backup_folder."
else
  echo "Error: $1 does not exist or does not have a backups folder."
fi