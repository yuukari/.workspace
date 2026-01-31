#!/bin/bash

source ~/.config/hypr/scripts/helpers.sh

dev_env_control_menu () {
    item=$(GUM_CHOOSE_PADDING="2 8" gum choose --header="Dev-env control menu" "󰐊 Start" "󰓛 Stop" "󰜉 Restart all" "󱃾 Restart k3s" "󰡨 Restart docker")
    case $item in
        "󰐊 Start")
            dev_env_control_start
            ;;
        "󰓛 Stop")
            dev_env_control_stop
            ;;
        "󰜉 Restart all")
            dev_env_control_restart_all
            ;;
        "󱃾 Restart k3s")
            dev_env_control_restart_k3s
            ;;
        "󰡨 Restart docker")
            dev_env_control_restart_docker
            ;;
    esac
}

dev_env_control_start () {
    echo -e "\e[34m\n 󰐊 Starting dev-env services...\e[0m\n"
    sudo systemctl start docker k3s
    print_result_by_exit_code
}

dev_env_control_stop () {
    echo -e "\e[34m\n 󰓛 Stopping dev-env services...\e[0m\n"
    sudo systemctl stop k3s docker
    print_result_by_exit_code
}

dev_env_control_restart_all () {
    echo -e "\e[34m\n 󰜉 Restarting dev-env services...\e[0m\n"
    sudo systemctl restart docker k3s
    print_result_by_exit_code
}

dev_env_control_restart_k3s () {
    echo -e "\e[34m\n 󰜉 Restarting k3s service...\e[0m\n"
    sudo systemctl restart k3s
    print_result_by_exit_code
}

dev_env_control_restart_docker () {
    echo -e "\e[34m\n 󰜉 Restarting docker service...\e[0m\n"
    sudo systemctl restart docker
    print_result_by_exit_code
}

dev_env_control_menu
