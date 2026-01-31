#!/bin/bash

power_profiles_menu () {
    profiles=$(powerprofilesctl list | grep -E '^[[:space:]]*(\*[[:space:]]*)?(performance|balanced|power-saver):' | sed 's/^[[:space:]]*\*[[:space:]]*//; s/:.*//')
    current_profile=$(powerprofilesctl get)

    item=$(GUM_CHOOSE_PADDING="3 8" gum choose --selected=$current_profile --header="Select power profile:" $profiles)
    if [[ "$item" == "" ]]; then
        exit
    fi

    powerprofilesctl set $item

    echo -e "\e[32m\n 󰄴 Power profile set to: $item\e[0m\n"
    read
}

power_profiles_menu