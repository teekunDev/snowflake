#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "Usage: vpn.sh (connect|disconnect|server|status) [--waybar]"
  exit 1
fi

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

if [[ "$1" == "connect" ]]; then
  wg-quick up pia
elif [[ "$1" == "disconnect" ]]; then
  wg-quick down pia
elif [[ "$1" == "server" ]]; then
  if [ $# -lt 2 ]; then
    echo "Usage: vpn.sh server (NAME)"
    echo "Server list: https://serverlist.piaservers.net/vpninfo/servers/v6"
    exit 1
  fi

  cd "$NIXOS_FILES/scripts/pia"

  pia_credentials=$(cat "$NIXOS_SECRETS/pia_credentials")
  sudo $pia_credentials VPN_PROTOCOL=wireguard PREFERRED_REGION="$2" ./get_region.sh

  echo "$2" > ~/.last_vpn_server

  cd "$SCRIPT_PATH"
elif [[ "$1" == "status" ]]; then
  if [[ "$2" == "--waybar" ]]; then
    res=$(sudo wg show pia)
    server=$(cat ~/.last_vpn_server)
    if [[ "$res" =~ "latest handshake" ]]; then
      icon=""
      class="on"
      status="Connected to $server"
    else
      icon=" "
      class="off"
      status="Disconnected from $server"
    fi
    printf '{"text": "%s", "class": "%s", "tooltip": "%s"}\n' "$icon" "$class" "$status"
  else
    sudo wg show pia
  fi
else
  echo "Usage: vpn.sh (connect|disconnect|status) [--waybar]"
  exit 1
fi