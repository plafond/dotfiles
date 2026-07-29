#!/bin/bash

# Get monitor value based on H (largest) or V (smallest) argument
# Usage: ./get_monitor_value.sh H  (returns largest monitor number)
#        ./get_monitor_value.sh V  (returns smallest monitor number)

# Check if argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [H|V|X]"
    echo "  H - returns largest monitor number"
    echo "  V - returns smallest monitor number"
    echo "  X - returns 3rd / external monitor number if connected"
    exit 1
fi

# Validate argument
if [[ "$1" != "H" && "$1" != "V" && "$1" != "X" ]]; then
    echo "Error: Argument must be 'H' or 'V' or 'X'"
    echo "  H - returns largest monitor number"
    echo "  V - returns smallest monitor number"
    echo "  X - returns 3rd / external monitor number if connected"
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
EXTERNAL=${MONITORS[0]}

MONITORS_SORTED=($(printf "%s\n" "${MONITORS[@]}" | sort -n))
#echo ${MONITORS_SORTED[@]}
if [ ${#MONITORS_SORTED[@]} -eq 3 ]; then
    EXTERNAL=${MONITORS_SORTED[0]}
    SMALLEST=${MONITORS_SORTED[1]}
    LARGEST=${MONITORS_SORTED[2]}
else
   for num in "${MONITORS[@]}"; do
     if (( num > LARGEST )); then
        LARGEST=$num
     fi
     if (( num < SMALLEST )); then
        SMALLEST=$num
     fi
   done
fi
 
# Return the requested value
if [ "$1" = "H" ]; then
   echo "$LARGEST"
elif [ "$1" = "V" ]; then
   echo "$SMALLEST"
elif [ "$1" = "X" ]; then
   echo "$EXTERNAL"
else
    echo "ERROR"
fi
