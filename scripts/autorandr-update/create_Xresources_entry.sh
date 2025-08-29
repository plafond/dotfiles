#!/bin/bash
export DISPLAY_H=$( ~/dotfiles/scripts/autorandr-update/get_monitor_value.sh H)
export DISPLAY_V=$( ~/dotfiles/scripts/autorandr-update/get_monitor_value.sh V)

# if display_h is 1 then set it to empty string
if [ "$DISPLAY_H" -eq 1 ]; then
    DISPLAY_H=""
fi

# if display_v is 1 then set it to empty string
if [ "$DISPLAY_V" -eq 1 ]; then
    DISPLAY_V=""
fi

FP=~/dotfiles/scripts/autorandr-update/tmp_xresources
echo "DISPLAY_H:DisplayPort-$DISPLAY_H" > $FP
echo "DISPLAY_V:DisplayPort-$DISPLAY_V" >> $FP
xrdb -merge $FP
rm $FP
