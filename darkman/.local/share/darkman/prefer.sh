#!/bin/sh

case "$1" in
    dark) gsettings set org.gnome.desktop.interface color-scheme "prefer-dark";gsettings set org.gnome.desktop.interface gtk-color-scheme "prefer-dark";;
    light) gsettings set org.gnome.desktop.interface color-scheme "prefer-light";gsettings set org.gnome.desktop.interface gtk-color-scheme "prefer-dark";;
esac
