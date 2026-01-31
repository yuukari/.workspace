#!/bin/bash

ask() {
    local prompt="$1 (y/n): "
    local default="$2"

    while true; do
        read -p "$prompt" -n 1 -r
        echo

        if [[ -z "$REPLY" && -n "$default" ]]; then
            [[ "$default" =~ ^[Yy]$ ]] && return 0 || return 1
        fi

        case $REPLY in
            [Yy]) return 0 ;;
            [Nn]) return 1 ;;
            *) echo "Please, enter 'y' or 'n', or press Ctrl+C to cancel" ;;
        esac
    done
}