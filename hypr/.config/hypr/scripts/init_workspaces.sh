#!/bin/bash

# Wait for tmux continuum to restore the sessions
while [ ! -f ~/.tmux/resurrect/restore_complete ]; do
    sleep 0.1
done

# Launch Alacritty and move to workspace 1
hyprctl dispatch workspace 1

SESSION_FLASH_LEARN="Flash Learn"
PATH_FLASH_LEARN="/run/media/shakleen/programming/flash-learn-mono/"

if ! tmux has-session -t "$SESSION_FLASH_LEARN" 2>/dev/null; then
    # Session does not exist, create a new one and attach
    alacritty -e tmux new -A -s "$SESSION_FLASH_LEARN" -c "$PATH_FLASH_LEARN" &
else
    # Session exists, attach to it (assuming it was restored with history)
    echo "Tmux session '$SESSION_FLASH_LEARN' already exists. Attaching to it."
    alacritty -e tmux attach -t "$SESSION_FLASH_LEARN" &
fi

# Give Alacritty/tmux a moment to start
sleep 2

# Create two more detached tmux sessions in specified directories
SESSION_RESUME="Resume"
PATH_RESUME="/run/media/shakleen/programming/Curriculum-Vitae/"

if ! tmux has-session -t "$SESSION_RESUME" 2>/dev/null; then
    # Session does not exist, create a new detached one
    tmux new -s "$SESSION_RESUME" -d -c "$PATH_RESUME"
else
    echo "Tmux session '$SESSION_RESUME' already exists. Skipping creation."
    # If the session exists, we assume it was restored by tmux-continuum
    # and has its history. No action needed as it's detached.
fi

SESSION_DOT_FILES="Dot Files"
PATH_DOT_FILES="/home/shakleen/dotfiles"

if ! tmux has-session -t "$SESSION_DOT_FILES" 2>/dev/null; then
    # Session does not exist, create a new detached one
    tmux new -s "$SESSION_DOT_FILES" -d -c "$PATH_DOT_FILES"
else
    echo "Tmux session '$SESSION_DOT_FILES' already exists. Skipping creation."
    # If the session exists, we assume it was restored by tmux-continuum
    # and has its history. No action needed as it's detached.
fi

SESSION_TERMINAL="Terminal"
PATH_TERMINAL="/home/shakleen"

if ! tmux has-session -t "$SESSION_TERMINAL" 2>/dev/null; then
    # Session does not exist, create a new detached one
    tmux new -s "$SESSION_TERMINAL" -d -c "$PATH_TERMINAL"
else
    echo "Tmux session '$SESSION_TERMINAL' already exists. Skipping creation."
    # If the session exists, we assume it was restored by tmux-continuum
    # and has its history. No action needed as it's detached.
fi

SESSION_NEETCODE="NeetCode"
PATH_NEETCODE="/run/media/shakleen/programming/neetcode/"

if ! tmux has-session -t "$SESSION_NEETCODE" 2>/dev/null; then
    # Session does not exist, create a new detached one
    tmux new -s "$SESSION_NEETCODE" -d -c "$PATH_NEETCODE"
else
    echo "Tmux session '$SESSION_NEETCODE' already exists. Skipping creation."
    # If the session exists, we assume it was restored by tmux-continuum
    # and has its history. No action needed as it's detached.
fi

# Launch Zen Browser and move to workspace 3
hyprctl dispatch workspace 3
zen-browser &

# Launch Dolphin and move to workspace 4
hyprctl dispatch workspace 4
dolphin &

# Launch qbittorrent and move to workspace 5
hyprctl dispatch workspace 5
qbittorrent &
