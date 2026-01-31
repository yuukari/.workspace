#!/bin/bash

source ~/.zshenv
source "$WORKSPACE_DIR/.env"
source ~/.config/hypr/scripts/helpers.sh

openconnect_menu () {
    STATUS="(N/C)"
    if [ -f /tmp/openconnect ]; then
        STATUS="(CONN)"
    fi
    item=$(GUM_CHOOSE_PADDING="3 8" gum choose --header="OpenConnect VPN menu $STATUS" "󰙨 $CORP_OPENCONNECT_NAME stage" "󱐋 $CORP_OPENCONNECT_NAME prod" "󰓛 Stop connection")
    case $item in
        "󰙨 $CORP_OPENCONNECT_NAME stage")
            echo -e "\e[34m\n 󰐊 Starting OpenConnect for $CORP_OPENCONNECT_NAME stage...\e[0m\n"

            echo "$CORP_OPENCONNECT_PASSWORD" | sudo openconnect -b --pid-file=/tmp/openconnect --protocol=anyconnect -u "$CORP_OPENCONNECT_USERNAME" --http-auth=basic --passwd-on-stdin "https://$CORP_OPENCONNECT_STG_HOST"
            print_result_by_exit_code
            ;;
        "󱐋 $CORP_OPENCONNECT_NAME prod")
            echo -e "\e[34m\n 󰐊 Starting OpenConnect for $CORP_OPENCONNECT_NAME production...\e[0m\n"

            echo "$CORP_OPENCONNECT_PASSWORD" | sudo openconnect -b --pid-file=/tmp/openconnect --protocol=anyconnect -u "$CORP_OPENCONNECT_USERNAME" --http-auth=basic --passwd-on-stdin "https://$CORP_OPENCONNECT_PROD_HOST"
            print_result_by_exit_code
            ;;
        "󰓛 Stop connection")
            echo -e "\e[34m\n 󰓛 Stopping OpenConnect processes...\e[0m\n"
            sudo killall openconnect
            print_result_by_exit_code
            ;;
    esac
}

openconnect_menu
