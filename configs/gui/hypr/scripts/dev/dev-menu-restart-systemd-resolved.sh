#!/bin/bash

source ~/.config/hypr/scripts/helpers.sh

echo -e "\e[34m\n 󱞒 Restarting systemd-resolved service...\e[0m\n"

sudo systemctl restart systemd-resolved
print_result_by_exit_code