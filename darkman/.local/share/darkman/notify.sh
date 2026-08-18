#!/bin/sh

case "$1" in
    dark) notify-send "Dark theme set";;
    light) notify-send "Light theme set";;
esac
