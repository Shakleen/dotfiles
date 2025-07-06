#!/bin/bash

DEVICE="asue120b:00-04f3:31c0-touchpad"
STATE_FILE="/home/shakleen/dotfiles/hypr/.config/hypr/state/trackpad_state.txt"

# Create state file if it doesn't exist and initialize with current trackpad state
if [ ! -f "$STATE_FILE" ]; then
    mkdir -p "$(dirname "$STATE_FILE")"
    hyprctl getoption device:$DEVICE:enabled | grep "int:" | awk '{print $2}' > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "1" ]; then
    hyprctl keyword "device[$DEVICE]:enabled" false
    echo "0" > "$STATE_FILE"
    notify-send "Trackpad disabled"
else
    hyprctl keyword "device[$DEVICE]:enabled" true
    echo "1" > "$STATE_FILE"
    notify-send "Trackpad enabled"
fi