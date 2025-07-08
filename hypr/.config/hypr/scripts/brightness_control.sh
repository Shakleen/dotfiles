#!/bin/bash

case "$1" in
    up)
        swayosd-client --brightness +5
        ;;
    down)
        swayosd-client --brightness -5
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac
