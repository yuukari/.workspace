#!/bin/bash

ui_menu () {
    item=$(GUM_CHOOSE_PADDING="3 8" gum choose --header="UI menu" " Reload hyprland" " Reload waybar")
    case $item in
        " Reload hyprland")
            ui_menu_reload_hyprland
            ;;
        " Reload waybar")
            ui_menu_reload_waybar
            ;;
    esac
}

ui_menu_reload_hyprland () {
    hyprctl reload
}

ui_menu_reload_waybar () {
    killall waybar
    hyprctl dispatch exec waybar 
}

ui_menu