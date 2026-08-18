#!/bin/sh

case "$1" in
    dark) kill -s USR1 `pgrep foot`;;
    light) kill -s USR2 `pgrep foot`;;
esac
