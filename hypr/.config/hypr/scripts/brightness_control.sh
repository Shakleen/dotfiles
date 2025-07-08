#!/bin/bash

# Get the current brightness level
current_brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)

# Calculate brightness percentage
brightness_percentage=$(( (current_brightness * 100) / max_brightness ))

# Determine the action (up or down)
case "$1" in
    up)
        brightnessctl s +5%
        ;;
    down)
        brightnessctl s 5%-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Get the new brightness level after the change
new_brightness=$(brightnessctl g)
new_brightness_percentage=$(( (new_brightness * 100) / max_brightness ))

# Display the brightness level using swayosd
swayosd-client --brightness "$new_brightness_percentage"