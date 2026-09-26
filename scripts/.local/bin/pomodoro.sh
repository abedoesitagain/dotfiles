#!/usr/bin/env bash

WORK=${1:-25}      # first argument = work minutes, default 25
SHORT=${2:-5}      # second argument = short break, default 5
LONG=${3:-20}      # third argument = long break, default 20
CYCLES=${4:-4}     # fourth argument = cycles before long break, default 4

bell="/usr/share/sounds/freedesktop/stereo/complete.oga"  # fallback sound

for ((i=1; i<=CYCLES; i++)); do
    notify-send -u critical "Pomodoro $i/$CYCLES" "Focus — ${WORK} min" && \
    paplay "$bell" 2>/dev/null || aplay "$bell" 2>/dev/null

    sleep "${WORK}m"

    if (( i == CYCLES )); then
        notify-send -u critical "Pomodoro Cycle Complete" "Long break — ${LONG} min"
        paplay "$bell" 2>/dev/null || aplay "$bell" 2>/dev/null
        sleep "${LONG}m"
    else
        notify-send "Pomodoro $i" "Short break — ${SHORT} min"
        paplay "$bell" 2>/dev/null || aplay "$bell" 2>/dev/null
        sleep "${SHORT}m"
    fi
done

notify-send -u critical "Pomodoro Session Finished" "Get back to real work."
paplay "$bell" 2>/dev/null || aplay "$bell" 2>/dev/null
