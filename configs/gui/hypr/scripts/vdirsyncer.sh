#!/bin/bash

sync_interval=600 # Delay for 600 seconds (10 minutes) before next sync

sync () {
    export CORP_URL="$(pass vdirsyncer/corp/url)"
    export CORP_USERNAME="$(pass vdirsyncer/corp/username)"
    export CORP_PASSWORD="$(pass vdirsyncer/corp/password)"
    export PRIVATE_URL="$(pass vdirsyncer/private/url)"
    vdirsyncer sync
}

sleep 10
while true; do
    sync
    sleep $sync_interval
done