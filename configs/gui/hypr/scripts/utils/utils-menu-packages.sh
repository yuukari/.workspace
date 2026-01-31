#!/bin/bash

source ~/.config/hypr/scripts/helpers.sh

packages_menu () {
    item=$(GUM_CHOOSE_PADDING="11 31" gum choose --header="Packages actions" "󱧕 Install packages" "󱧔 Remove packages" "󰗂 Update packages database" "󰦗 Upgrade system" "󰃢 Clean packages cache")
    case $item in
    "󱧕 Install packages")
        install_packages_menu
        ;;
    "󱧔 Remove packages")
        remove_packages
        ;;
		"󰗂 Update packages database")
        update_packages_database
        ;;
		"󰦗 Upgrade system")
        upgrade_system
        ;;
    "󰃢 Clean packages cache")
        clean_packages_cache
        ;;
    esac
}

########################
### Install packages ###
########################

install_packages_menu () {
    item=$(GUM_CHOOSE_PADDING="11 31" gum choose --header="Choose package manager:" "󰽥 Pacman" "󰊢 AUR")
    case $item in
        "󰽥 Pacman")
            install_packages_pacman
            ;;
        "󰊢 AUR")
            install_packages_aur
            ;;
    esac
}

install_packages_pacman () {
    packages=$(pacman -Slq | GUM_FILTER_PADDING="3 8" gum filter --header="Find and pick packages you want to install via pacman:" --no-limit)
    if [[ -n "$packages" ]]; then
        to_install=$(echo "$packages" | tr '\n' ' ')
        echo -e "\e[34m\n 󱧕 Packages to install: $to_install\e[0m\n"
        echo "$packages" | tr '\n' ' ' | xargs sudo pacman -S --noconfirm
        echo -e "\e[32m\n 󰄴 Installed packages: $to_install\e[0m\n"
        read
    fi
}

install_packages_aur () {
    packages=$(yay -Slqa | GUM_FILTER_PADDING="3 8" gum filter --header="Find and pick packages you want to install via AUR:" --no-limit)
    if [[ -n "$packages" ]]; then
        to_install=$(echo "$packages" | tr '\n' ' ')
        echo -e "\e[34m\n 󱧕 Packages to install: $to_install\e[0m\n"
        echo "$packages" | tr '\n' ' ' | xargs yay -S --noconfirm
        echo -e "\e[32m\n 󰄴 Installed packages: $to_install\e[0m\n"
        read
    fi
}

#######################
### Remove packages ###
#######################

remove_packages () {
    packages=$(yay -Qqe | GUM_FILTER_PADDING="3 8" gum filter --header="Find and pick packages you want to remove:" --no-limit)
    if [[ -n "$packages" ]]; then
        to_remove=$(echo "$packages" | tr '\n' ' ')
        echo -e "\e[31m\n 󱧔 Packages to remove: $to_remove\e[0m\n"
        echo "$packages" | tr '\n' ' ' | xargs sudo pacman -R --noconfirm
        echo -e "\e[32m\n 󰄴 Removed packages: $to_remove\e[0m\n"
        read
    fi
}

############################
### Clean packages cache ###
############################

clean_packages_cache () {
    echo -e "\e[34m\n 󰃢 Cleaning packages cache\e[0m\n"
    (sudo pacman -Scc --noconfirm && yay -Scc --noconfirm)
    print_result_by_exit_code
}

#######################
### Update packages ###
#######################

update_packages_database () {
	echo -e "\e[34m\n 󰗂 Updating packages database\e[0m\n"
	sudo pacman -Sy
	print_result_by_exit_code
}

upgrade_system () {
	echo -e "\e[34m\n 󰦗 Upgrading system\e[0m\n"
	sudo pacman -Suy
	print_result_by_exit_code
}

packages_menu
