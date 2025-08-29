#!/bin/bash

# Script to detect connected HDMI and DisplayPort monitors
# Outputs the monitor numbers/identifiers that are connected

echo "Detecting connected monitors..."

# Method 1: Using xrandr (requires X server)
if command -v xrandr >/dev/null 2>&1; then
    echo "=== Using xrandr ==="
    
    # Get all connected monitors with HDMI or DisplayPort in their name
    connected_monitors=$(xrandr --query | grep " connected " | grep -E '(HDMI|DisplayPort)')
    
    if [ -n "$connected_monitors" ]; then
        echo "Connected monitors:"
        echo "$connected_monitors" | while read -r line; do
            monitor=$(echo "$line" | cut -d' ' -f1)
            # Extract the monitor number
            if [[ $monitor =~ (HDMI|DisplayPort)-[A-Za-z]*-?([0-9]+) ]]; then
                echo "  $monitor (Port ${BASH_REMATCH[2]})"
            elif [[ $monitor =~ (HDMI|DisplayPort)-([0-9]+) ]]; then
                echo "  $monitor (Port ${BASH_REMATCH[2]})"
            else
                echo "  $monitor"
            fi
        done
    else
        echo "No HDMI/DisplayPort monitors connected."
    fi
    
    echo ""
fi

# Method 2: Using /sys/class/drm directory (works without X server)
echo "=== Using kernel DRM subsystem ==="

if [ -d "/sys/class/drm" ]; then
    # Find all HDMI and DisplayPort connections
    dp_hdmi_ports=$(find /sys/class/drm/ -name "card*-HDMI*" -o -name "card*-DP*" 2>/dev/null)
    
    if [ -n "$dp_hdmi_ports" ]; then
        echo "Connected monitors:"
        
        for port in $dp_hdmi_ports; do
            if [ -f "$port/status" ]; then
                status=$(cat "$port/status")
                port_name=$(basename "$port")
                
                if [ "$status" = "connected" ]; then
                    # Extract card number and port
                    if [[ $port_name =~ card([0-9]+)-(DP|HDMI-A|HDMI)-([0-9]+) ]]; then
                        card="${BASH_REMATCH[1]}"
                        type="${BASH_REMATCH[2]}"
                        num="${BASH_REMATCH[3]}"
                        
                        # Try to get EDID info (monitor model)
                        model="Unknown"
                        if [ -f "$port/edid" ]; then
                            if command -v parse-edid >/dev/null 2>&1; then
                                model=$(parse-edid < "$port/edid" 2>/dev/null | grep "ModelName" | sed 's/.*"\(.*\)".*/\1/' || echo "Unknown")
                            fi
                        fi
                        
                        echo "  $port_name: $type Port $num on Card $card ($model)"
                    else
                        echo "  $port_name: Connected"
                    fi
                fi
            fi
        done
    else
        echo "No HDMI/DisplayPort ports found."
    fi
else
    echo "DRM subsystem not available."
fi

# Summary of connected ports (simple output)
echo -e "\n=== Connected Monitor Summary ==="
connected_ports=$(find /sys/class/drm/ -name "card*-HDMI*" -o -name "card*-DP*" 2>/dev/null | while read port; do
    if [ -f "$port/status" ] && [ "$(cat "$port/status")" = "connected" ]; then
        basename "$port" | sed -E 's/card[0-9]+-(DP|HDMI-A)-([0-9]+)/\2/'
    fi
done | sort -n)

if [ -n "$connected_ports" ]; then
    echo "Connected ports: $(echo $connected_ports | tr '\n' ' ')"
else
    echo "No ports connected"
fi