#!/bin/bash
VPN=$(nmcli con show --active | grep wire | cut -d " " -f 1)

if [ -z "$VPN" ]; then
  echo ""
else
  echo "󰯅"
fi

