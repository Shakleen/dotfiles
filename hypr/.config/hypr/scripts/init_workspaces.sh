#!/bin/bash

# Launch Alacritty and move to workspace 1
hyprctl dispatch workspace 1
alacritty -e tmux new -s "Flash Learn" -c /run/media/shakleen/programming/flash-learn-mono/ &

# Give Alacritty/tmux a moment to start
sleep 1

# Create two more detached tmux sessions in specified directories
tmux new -s "Resume" -d -c /run/media/shakleen/programming/Curriculum-Vitae/
tmux new -s "Dot Files" -d -c /home/shakleen/dotfiles

# Launch Google Chrome and move to workspace 3
hyprctl dispatch workspace 3
google-chrome-stable &

# Launch Dolphin and move to workspace 4
hyprctl dispatch workspace 4
dolphin &