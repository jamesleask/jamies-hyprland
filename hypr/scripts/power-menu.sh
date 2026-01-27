#!/bin/bash
# Power Menu Script for Hyprland
# Uses wofi to display power options

OPTIONS="󰌾 Lock\n󰍃 Logout\n󰜉 Restart\n󰐥 Shutdown"

SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -p "Power" -theme-str 'window {width: 250px; height: 210px;} listview {lines: 4; columns: 1;}')

case "$SELECTED" in
    "󰌾 Lock")
        swaylock
        ;;
    "󰍃 Logout")
        loginctl terminate-user ""
        ;;
    "󰜉 Restart")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
esac
