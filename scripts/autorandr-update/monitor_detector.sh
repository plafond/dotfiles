#!/bin/bash

# Monitor Detector Script
# Detects connected HDMI/DisplayPort monitors and outputs their port numbers

# Configuration options
DETAILED_MODE=false
DETECTION_METHOD="auto"  # Options: xrandr, drm, auto

# Process command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--detailed)
            DETAILED_MODE=true
            shift
            ;;
        -m|--method)
            DETECTION_METHOD="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  -d, --detailed    Show detailed information about monitors"
            echo "  -m, --method X    Detection method: xrandr, drm, or auto (default)"
            echo "  -h, --help        Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Function to get monitor info using xrandr
get_xrandr_monitors() {
    if ! command -v xrandr >/dev/null 2>&1; then
        echo "xrandr not available"
        return 1
    fi
    
    if $DETAILED_MODE; then
        echo "=== HDMI/DisplayPort Monitors (xrandr) ==="
        xrandr --query | grep " connected " | grep -E '(HDMI|DisplayPort)' | 
        while read -r line; do
            monitor=$(echo "$line" | cut -d' ' -f1)
            resolution=$(echo "$line" | grep -oP '\d+x\d+' | head -1)
            
            # Extract monitor number
            if [[ $monitor =~ (HDMI|DisplayPort)-[A-Za-z]*-?([0-9]+) ]]; then
                port="${BASH_REMATCH[2]}"
                type="${BASH_REMATCH[1]}"
                echo "Port $port: $type ($monitor) - $resolution"
            elif [[ $monitor =~ (HDMI|DisplayPort)-([0-9]+) ]]; then
                port="${BASH_REMATCH[2]}"
                type="${BASH_REMATCH[1]}"
                echo "Port $port: $type ($monitor) - $resolution"
            fi
        done
    else
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
    fi
}

# Function to get monitor info using kernel DRM subsystem
get_drm_monitors() {
    if [ ! -d "/sys/class/drm" ]; then
        echo "DRM subsystem not available"
        return 1
    fi
    
    if $DETAILED_MODE; then
        echo "=== HDMI/DisplayPort Monitors (DRM) ==="
        find /sys/class/drm/ -name "card*-HDMI*" -o -name "card*-DP*" 2>/dev/null |
        while read port; do
            if [ -f "$port/status" ] && [ "$(cat "$port/status")" = "connected" ]; then
                port_name=$(basename "$port")
                if [[ $port_name =~ card([0-9]+)-(DP|HDMI-A)-([0-9]+) ]]; then
                    card="${BASH_REMATCH[1]}"
                    type="${BASH_REMATCH[2]}"
                    num="${BASH_REMATCH[3]}"
                    echo "Port $num: $type on Card $card ($port_name)"
                fi
            fi
        done
    else
        find /sys/class/drm/ -name "card*-HDMI*" -o -name "card*-DP*" 2>/dev/null | 
        while read port; do
            if [ -f "$port/status" ] && [ "$(cat "$port/status")" = "connected" ]; then
                basename "$port" | sed -E 's/card[0-9]+-(DP|HDMI-A)-([0-9]+)/\2/'
            fi
        done | sort -n | tr '\n' ' '
    fi
}

# Detect monitors based on selected method
case "$DETECTION_METHOD" in
    xrandr)
        get_xrandr_monitors
        ;;
    drm)
        get_drm_monitors
        ;;
    auto)
        # Try xrandr first, then fall back to DRM
        if command -v xrandr >/dev/null 2>&1; then
            get_xrandr_monitors
        else
            get_drm_monitors
        fi
        ;;
    *)
        echo "Unknown detection method: $DETECTION_METHOD"
        exit 1
        ;;
esac