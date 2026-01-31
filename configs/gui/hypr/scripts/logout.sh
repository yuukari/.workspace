#!/bin/bash

GUM_CONFIRM_PADDING="3 8" gum confirm "Log out from session?" --default="No" && if [ $? = "0" ]; then hyprctl dispatch exit; fi;