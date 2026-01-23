#!/bin/bash
# Power Menu Script for Hyprland
# Uses wofi to display power options

OPTIONS="󰌾 Lock\n󰍃 Logout\n󰜉 Restart\n󰐥 Shutdown"

SELECTED=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Power" --width 200 --height 180 --cache-file /dev/null)

case "$SELECTED" in
    "󰌾 Lock")
        swaylock
        ;;
    "󰍃 Logout")
        hyprctl dispatch exit
        ;;
    "󰜉 Restart")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
esac
