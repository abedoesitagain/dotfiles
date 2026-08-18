#!/bin/sh

case "$1" in
    dark) export QT_STYLE_OVERRIDE=Adwaita-Dark;;
    light) export QT_STYLE_OVERRIDE=Adwaita;;
esac
