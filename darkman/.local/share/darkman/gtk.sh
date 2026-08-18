#!/bin/sh

case "$1" in
    dark) gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Dark";gsettings set org.gnome.desktop.interface gtk3-theme "Gruvbox-Dark"; gsettings set org.gnome.desktop.interface icon-theme "Gruvbox-Dark";export GTK_THEME="Gruvbox-Dark";export GTK3_THEME="Gruvbox-Dark";;
    light) gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Light";gsettings set org.gnome.desktop.interface gtk3-theme "Gruvbox-Light"; gsettings set org.gnome.desktop.interface icon-theme "Gruvbox-Light";export GTK_THEME="Gruvbox-Light";export GTK3_THEME="Gruvbox-Light";;
esac
