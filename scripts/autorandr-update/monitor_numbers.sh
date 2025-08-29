#!/bin/bash

# Simple script to detect connected HDMI and DisplayPort monitor numbers
# Outputs just the port numbers that are connected

# Function to get monitor numbers using xrandr
get_xrandr_monitors() {
    if ! command -v xrandr >/dev/null 2>&1; then
        return
    fi
    
    # Find connected displays
    xrandr --query | grep " connected " | grep -E '(HDMI|DisplayPort)' | 
    while read -r line; do
        monitor=$(echo "$line" | cut -d' ' -f1)
        
        # Extract monitor number
        if [[ $monitor =~ (HDMI|DisplayPort)-[A-Za-z]*-?([0-9]+) ]]; then
            echo "${BASH_REMATCH[2]}"
        elif [[ $monitor =~ (HDMI|DisplayPort)-([0-9]+) ]]; then
            echo "${BASH_REMATCH[2]}"
        fi
    done | sort -n | tr '\n' ' '
}

# Function to get monitor numbers using kernel DRM subsystem
get_drm_monitors() {
    if [ ! -d "/sys/class/drm" ]; then
        return
    fi
    
    find /sys/class/drm/ -name "card*-HDMI*" -o -name "card*-DP*" 2>/dev/null | 
    while read port; do
        if [ -f "$port/status" ] && [ "$(cat "$port/status")" = "connected" ]; then
            basename "$port" | sed -E 's/card[0-9]+-(DP|HDMI-A)-([0-9]+)/\2/'
        fi
    done | sort -n | tr '\n' ' '
}

# Check which method to use
if command -v xrandr >/dev/null 2>&1; then
    xrandr_monitors=$(get_xrandr_monitors)
    echo "$xrandr_monitors"
else
    drm_monitors=$(get_drm_monitors)
    echo "$drm_monitors"
fi