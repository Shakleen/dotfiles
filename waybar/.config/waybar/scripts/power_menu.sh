#!/bin/bash

chosen=$(echo -e "Lock\nReboot\nShutdown\nSuspend\nHibernate" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
    "Lock") hyprlock;;
    "Reboot") systemctl reboot;;
    "Shutdown") systemctl poweroff;;
    "Suspend") systemctl suspend;;
    "Hibernate") systemctl hibernate;;
esac