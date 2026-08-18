#!/bin/sh

#case "$1" in
#    dark) gammastep -O 4500 ;;
#    light) gammastep -x;;
#esac
gammastep -m wayland -b 0.95:0.8 -l 0:0 -t 6000:4500 &
