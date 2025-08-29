#!/bin/bash

# Create template files from monitor_numbers.sh output
# Replaces MONITOR_H with largest monitor number
# Replaces MONITOR_V with smallest monitor number

# Path to configuration files
CONFIG_DIR=~/.config/autorandr/multi-mon_template
TARGET_DIR=~/.config/autorandr/multi-mon
CONFIG_FILE="$CONFIG_DIR/config"
SETUP_FILE="$CONFIG_DIR/setup"
CONFIG_TMP="$CONFIG_DIR/config.tmp"
SETUP_TMP="$CONFIG_DIR/setup.tmp"
SCRIPT_DIR=~/dotfiles/scripts/autorandr-update/

# Get monitor numbers from monitor_numbers.sh
MONITOR_NUMBERS=$($SCRIPT_DIR/monitor_numbers.sh)

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

echo "Largest monitor number: $LARGEST"
echo "Smallest monitor number: $SMALLEST"

# Variables set for template processing
MONITOR_H=$LARGEST
MONITOR_V=$SMALLEST

# Create temporary config file
if [ -f "$CONFIG_FILE" ]; then
    # Copy the original file
    cp "$CONFIG_FILE" "$CONFIG_TMP"
    
    # Replace MONITOR_H with largest number and MONITOR_V with smallest number
    sed -i "s/MONITOR_H/$LARGEST/g" "$CONFIG_TMP"
    sed -i "s/MONITOR_V/$SMALLEST/g" "$CONFIG_TMP"
    
    echo "Created $CONFIG_TMP with MONITOR_H=$LARGEST and MONITOR_V=$SMALLEST"

    # Move the temporary file to the target directory
    mv "$CONFIG_TMP" "$TARGET_DIR/config"
else
    echo "Error: Config file $CONFIG_FILE not found."
    exit 1
fi

# Create temporary setup file
if [ -f "$SETUP_FILE" ]; then
    # Copy the original file
    cp "$SETUP_FILE" "$SETUP_TMP"
    
    # Replace MONITOR_H with largest number and MONITOR_V with smallest number
    sed -i "s/MONITOR_H/$LARGEST/g" "$SETUP_TMP"
    sed -i "s/MONITOR_V/$SMALLEST/g" "$SETUP_TMP"
    
    echo "Created $SETUP_TMP with MONITOR_H=$LARGEST and MONITOR_V=$SMALLEST"

    # Move the temporary file to the target directory
    mv "$SETUP_TMP" "$TARGET_DIR/setup"
else
    echo "Error: Setup file $SETUP_FILE not found."
    exit 1
fi


echo "Template files created successfully."
echo ""
echo "To export variables to your shell, run:"
echo "eval \$(./create_monitor_templates.sh | tail -1)"
echo ""
echo "export MONITOR_H=$LARGEST; export MONITOR_V=$SMALLEST"
