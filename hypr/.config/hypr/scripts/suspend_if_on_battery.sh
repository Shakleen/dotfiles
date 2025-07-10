#!/bin/sh
if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ]; then
    systemctl suspend
fi