#!/bin/bash

# mem_usage.sh
#
# Displays the top 10 processes sorted by Memory usage, with color-coded output
# and truncated command names for better readability.

ps -aux | sort -nr -k 4 | head -n 10 | \
awk '
BEGIN {
    # Define ANSI color codes
    HEADER="\033[1;36m";      # Bold Cyan for the header
    GREEN="\033[0;32m";
    YELLOW="\033[1;33m";
    RED="\033[0;31m";
    NC="\033[0m";             # No Color (to reset)
    
    # Print the header
    print HEADER "USER\tPID\t%CPU\t%MEM\tCOMMAND" NC
}
{
    # Reconstruct the full command string from the 11th column onwards
    cmd = ""; 
    for(i=11; i<=NF; i++) {
        cmd = cmd $i " "
    }
    
    # Truncate the command if it is longer than 70 characters
    if (length(cmd) > 70) {
        cmd = substr(cmd, 1, 67) "..."
    }
    
    # Determine color for %CPU based on value
    cpu_color = GREEN;
    if ($3 > 50) cpu_color = RED;
    else if ($3 > 20) cpu_color = YELLOW;
    
    # Determine color for %MEM based on value
    mem_color = GREEN;
    if ($4 > 10) mem_color = RED;
    else if ($4 > 5) mem_color = YELLOW;
    
    # Print the formatted and colorized row
    printf "%s\t%s\t%s%.1f%s\t%s%.1f%s\t%s\n", $1, $2, cpu_color, $3, NC, mem_color, $4, NC, cmd
}' | \
column -t -s $'\t'
