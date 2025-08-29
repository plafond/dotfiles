#!/bin/bash

# Get monitor value based on H (largest) or V (smallest) argument
# Usage: ./get_monitor_value.sh H  (returns largest monitor number)
#        ./get_monitor_value.sh V  (returns smallest monitor number)

# Check if argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [H|V]"
    echo "  H - returns largest monitor number"
    echo "  V - returns smallest monitor number"
    exit 1
fi

# Validate argument
if [[ "$1" != "H" && "$1" != "V" ]]; then
    echo "Error: Argument must be 'H' or 'V'"
    echo "  H - returns largest monitor number"
    echo "  V - returns smallest monitor number"
    exit 1
fi

# Get monitor numbers from monitor_numbers.sh
MONITOR_NUMBERS=$(~/dotfiles/scripts/autorandr-update/monitor_numbers.sh)

# Check if we got any monitor numbers
if [ -z "$MONITOR_NUMBERS" ]; then
    echo "Error: No monitors detected."
    exit 1
fi

# Convert space-separated string to array
read -ra MONITORS <<< "$MONITOR_NUMBERS"

# Ensure at least one monitor was found
if [ ${#MONITORS[@]} -eq 0 ]; then
    echo "Error: No monitor numbers found."
    exit 1
fi

# Find largest and smallest monitor numbers
LARGEST=${MONITORS[0]}
SMALLEST=${MONITORS[0]}

for num in "${MONITORS[@]}"; do
    if (( num > LARGEST )); then
        LARGEST=$num
    fi
    if (( num < SMALLEST )); then
        SMALLEST=$num
    fi
done

# Return the requested value
if [ "$1" = "H" ]; then
    echo "$LARGEST"
else
    echo "$SMALLEST"
fi
