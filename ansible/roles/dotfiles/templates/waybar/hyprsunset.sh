#!/usr/bin/env bash

# CONFIG ----
MIN_TEMP=1500       # warmest
MAX_TEMP=6500       # coolest
STEP=250            # change per scroll
STATE_FILE="/tmp/hyprsunset_state"  # persistent storage for temp & enabled state
# ------------

init_state() {
    if [[ ! -f "$STATE_FILE" ]]; then
        echo "enabled=0" > "$STATE_FILE"
        echo "temp=4500" >> "$STATE_FILE"
    fi
}

load_state() {
    source "$STATE_FILE"
}

save_state() {
    echo "enabled=$enabled" > "$STATE_FILE"
    echo "temp=$temp" >> "$STATE_FILE"
}

apply_state() {
    if [[ "$enabled" == "1" ]]; then
        hyprctl hyprsunset temperature $temp >/dev/null 2>&1
    else
        hyprctl hyprsunset disable >/dev/null 2>&1
    fi
}

print_status() {
    if [[ "$enabled" == "1" ]]; then
        echo "{ \"text\": \"   $temp \", \"tooltip\": \"Hyprsunset ON ($temp K)\" }"
    else
        echo "{ \"text\": \"   off \", \"tooltip\": \"Hyprsunset OFF\" }"
    fi
}

init_state
load_state

case "$1" in
    scroll_up)
        temp=$(( temp - STEP ))
        (( temp < MIN_TEMP )) && temp=$MIN_TEMP
        enabled=1
        ;;
    scroll_down)
        temp=$(( temp + STEP ))
        (( temp > MAX_TEMP )) && temp=$MAX_TEMP
        enabled=1
        ;;
    toggle)
        enabled=$(( 1 - enabled ))
        ;;
esac

save_state
apply_state
print_status
