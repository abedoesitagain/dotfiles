#!/bin/sh

rm ~/.local/share/Xresources/Xresources
case "$1" in
    dark)  ln -s ~/.local/share/Xresources/Gruvbox-Dark  ~/.local/share/Xresources/Xresources ;;
    light) ln -s ~/.local/share/Xresources/Gruvbox-Light ~/.local/share/Xresources/Xresources ;;
esac
xrdb -merge ~/.local/share/Xresources/Xresources
