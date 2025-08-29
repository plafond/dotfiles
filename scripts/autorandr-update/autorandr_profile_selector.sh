#!/bin/bash

# Script to automatically select autorandr profile based on connected monitor count
# Calls monitor_numbers.sh to get connected monitors and selects appropriate profile

SCRIPT_DIR=~/dotfiles/scripts/autorandr-update/

# Get monitor numbers from the monitor_numbers script
monitor_output=$("$SCRIPT_DIR/monitor_numbers.sh")

# Parse and count the monitor numbers
if [ -z "$monitor_output" ] || [ "$monitor_output" = " " ]; then
    monitor_count=0
else
    # Count non-empty space-separated entries
    monitor_count=$(echo "$monitor_output" | wc -w)
fi

echo "Detected $monitor_count external monitor(s): $monitor_output"

# Select appropriate autorandr profile based on monitor count
case $monitor_count in
    0)
        profile="laptop-only"
        echo "No external monitors detected, switching to mobile profile"
        ;;
    1)
        profile="portable-mon"
        echo "One external monitor detected, switching to docked profile"
        ;;
    2)
        profile="multi-mon"
        echo "Two external monitors detected, switching to dual profile"
        ;;
    *)
        profile="3-mon"
        echo "$monitor_count external monitors detected, switching to multi profile"
        ;;
esac

# Apply the selected profile
if command -v autorandr >/dev/null 2>&1; then
    echo "Applying autorandr profile: $profile"
    autorandr --load "$profile"
    if [ $? -eq 0 ]; then
        echo "Successfully applied profile: $profile"
    else
        echo "Failed to apply profile: $profile" >&2
        exit 1
    fi
else
    echo "Error: autorandr command not found" >&2
    exit 1
fi
