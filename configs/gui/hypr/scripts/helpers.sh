#!/bin/bash

print_result_by_exit_code () {
    if [[ "$?" == "0" ]]; then
        echo -e "\e[32m\n 󰄴 Done\e[0m\n"
    else
        echo -e "\e[31m\n 󰅚 Fail\e[0m\n"
    fi
    read
}