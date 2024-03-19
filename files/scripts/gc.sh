#!/usr/bin/env bash

while true; do
  read -p "This will delete all old generations. Are you sure? " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

nix-env --delete-generations old
nix-store --gc
nix-collect-garbage --delete-old