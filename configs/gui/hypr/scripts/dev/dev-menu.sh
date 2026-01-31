#!/bin/bash

item=$(GUM_CHOOSE_PADDING="2 8" gum choose --header="Developer menu" "󰌾 Pritunl VPN" "󰌾 OpenConnect VPN" "󱃾 k9s" "󰆼 Database explorer" "󱞒 Restart systemd-resolved" "󰒓 Dev-env control")
case $item in
    "󰌾 Pritunl VPN")
        hyprctl dispatch exec "kitty -o confirm_os_window_close=0 --class floating-terminal-pritunl-vpn zsh -c pritunl-client"
        ;;
    "󰌾 OpenConnect VPN")
        ~/.config/hypr/scripts/dev/dev-menu-openconnect-vpn.sh
        ;;
    "󱃾 k9s")
        hyprctl dispatch exec "kitty zsh -c k9s"
        ;;
    "󰆼 Database explorer")
        hyprctl dispatch exec "(&>/dev/null /opt/PhpStorm*/bin/phpstorm.sh $HOME/Code/work/database &) && exit"
        ;;
    "󱞒 Restart systemd-resolved")
        ~/.config/hypr/scripts/dev/dev-menu-restart-systemd-resolved.sh
        ;;
    "󰒓 Dev-env control")
        ~/.config/hypr/scripts/dev/dev-menu-dev-env-control.sh
        ;;
esac