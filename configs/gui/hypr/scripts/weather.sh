#!/bin/bash

request_max_time=60
update_interval=600 # Delay for 600 seconds (10 minutes) before next update

init () {
    text="⛅️ N/A"
    echo "$text" > /tmp/wttr.in.text
}

update () {
    text="⛅️ N/A"
    echo "$text" > /tmp/wttr.in.text

    text_response=$(curl -s --max-time $request_max_time https://wttr.in/\?format="%c%t\n"\&lang=ru)
    curl_exit_code=$?
    if [[ "$curl_exit_code" != "0" ]]; then
        echo "Can't get weather: curl exited with code $curl_exit_code"
        return
    fi

    if [[ "${text_response,,}" == *"unknown"* ]]; then
        echo "Can't get weather: unexpected response - $text_response"
        return
    fi

    text=$text_response
    echo "$text" > /tmp/wttr.in.text

    echo "Weather updated: $text"
}

if [[ "$1" == "init" ]]; then
    init
    exit
fi

sleep 10

while true; do
    update
    sleep $update_interval
done