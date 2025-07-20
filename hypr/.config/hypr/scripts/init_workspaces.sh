#!/bin/bash

# Launch Alacritty and move to workspace 1
hyprctl dispatch workspace 1

SESSION_TERMINAL="Terminal"
PATH_TERMINAL="/home/shakleen"

alacritty -e tmux new -A -s "$SESSION_TERMINAL" -c "$PATH_TERMINAL" &

sleep 5

# Create more detached tmux sessions in specified directories
declare -A SESSIONS
SESSIONS["Resume"]="/run/media/shakleen/programming/Curriculum-Vitae/"
SESSIONS["Dots"]="/home/shakleen/dotfiles"
SESSIONS["FlashLearn"]="/run/media/shakleen/programming/flash-learn-mono/"
SESSIONS["NeetCode"]="/run/media/shakleen/programming/neetcode/"


# Loop through the sessions and create them if they don't exist
for SESSION_NAME in "${!SESSIONS[@]}"; do
    SESSION_PATH="${SESSIONS[$SESSION_NAME]}"

    if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        # Session does not exist, create a new detached one
        tmux new -s "$SESSION_NAME" -d -c "$SESSION_PATH"
    else
        echo "Tmux session '$SESSION_NAME' already exists. Skipping creation."
        # If the session exists, we assume it was restored by tmux-continuum
        # and has its history. No action needed as it's detached.
    fi
done

# Launch Zen Browser and move to workspace 3
hyprctl dispatch workspace 3
zen-browser &

# Launch Dolphin and move to workspace 4
hyprctl dispatch workspace 4
dolphin &

# Launch qbittorrent and move to workspace 5
hyprctl dispatch workspace 5
qbittorrent &

# Launch audacity for music
hyprctl dispathc workspace 6
audacity &
