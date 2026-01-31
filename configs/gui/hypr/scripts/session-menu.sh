#!/bin/bash

ITEM=$(GUM_CHOOSE_PADDING="3 8" gum choose --header="Session menu" "󰌾 Lock" "󰍃 Log out" "󰐥 Shutdown" "󰜉 Reboot" "󰤄 Sleep")

case $ITEM in
    "󰌾 Lock")
        loginctl lock-session
        ;;
    "󰍃 Log out")
        hyprctl dispatch exit
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
    "󰜉 Reboot")
        systemctl reboot
        ;;
    "󰤄 Sleep")
        systemctl suspend
        ;;
esac