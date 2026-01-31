#!/bin/bash

kitty --class floating-terminal-weather -o confirm_os_window_close=0 zsh -c "curl https://wttr.in\\?lang=ru && read"