#!/bin/bash

STATE_FILE="/home/shakleen/dotfiles/hypr/.config/hypr/state/microphone_state.txt"

# Get the default microphone source
SOURCE=$(pactl get-default-source)

# Create state file if it doesn't exist and initialize with current microphone state
if [ ! -f "$STATE_FILE" ]; then
    mkdir -p "$(dirname "$STATE_FILE")"
    pactl get-source-mute "$SOURCE" | grep "Mute:" | awk '{print $2}' | sed 's/yes/1/' | sed 's/no/0/' > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "1" ]; then
    # Microphone is currently muted, unmute it
    pactl set-source-mute "$SOURCE" 0
    echo "0" > "$STATE_FILE"
    swayosd-client --custom-message "Microphone Unmuted" --custom-icon "audio-input-microphone-symbolic"
else
    # Microphone is currently unmuted, mute it
    pactl set-source-mute "$SOURCE" 1
    echo "1" > "$STATE_FILE"
    swayosd-client --custom-message "Microphone Muted" --custom-icon "microphone-sensitivity-muted-symbolic"
fi
