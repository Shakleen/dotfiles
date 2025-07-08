#!/bin/bash

case "$1" in
    up)
        swayosd-client --output-volume +5
        ;;
    down)
        swayosd-client --output-volume -5
        ;;
    mute)
        swayosd-client --output-volume mute-toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac
