#!/bin/bash

item=$(GUM_CHOOSE_PADDING="2 8" gum choose --header="Utility menu" "󰖩 Wi-Fi" "󰂯 Bluetooth" "󰖀 Sound" "󰏗 Packages" "󱐋 Power profiles" "󰖲 UI")
case $item in
    "󰖩 Wi-Fi")
        hyprctl dispatch exec ~/.config/hypr/scripts/settings/setup-wifi.sh
        ;;
    "󰂯 Bluetooth")
        hyprctl dispatch exec ~/.config/hypr/scripts/settings/setup-bluetooth.sh
        ;;
    "󰖀 Sound")
        hyprctl dispatch exec ~/.config/hypr/scripts/settings/setup-sound.sh
        ;;
    "󰏗 Packages")
        hyprctl dispatch exec "kitty --class floating-terminal-packages -o confirm_os_window_close=0 zsh -c ~/.config/hypr/scripts/utils/utils-menu-packages.sh"
        ;;
    "󱐋 Power profiles")
        ~/.config/hypr/scripts/utils/utils-menu-power-profiles.sh
        ;;
    "󰖲 UI")
        ~/.config/hypr/scripts/utils/utils-menu-ui.sh
        ;;
esac