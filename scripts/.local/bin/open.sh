#!/bin/sh

opt="$(printf "video\nsearch yt video\nmusic\ntorrent dowload\ndownload video\ndownload with curl\ngit clone" | dmenu -p "from clipboard:")"
case $opt in
    "video") footclient -e tmux new-session mpv --input-ipc-server=/tmp/mpv-vid-socket "$(wl-paste)" & notify-send "opening $(wl-paste) with mpv";;
    "search yt video") query="$(wmenu -p "search:" < /dev/null)"; footclient -e mpv ytdl://ytsearch:"$query" & notify-send "looking up $query";;
    "music") mpv --no-video --input-ipc-server=/tmp/mpv-socket "$(wl-paste)";;
    "torrent download") transmission-remote -a "$(wl-paste)";;#footclient -e peerflix -kl "$(wl-paste)" & notify-send "opening torrent with mpv";;
    "download video") footclient -e yt-dlp "$(wl-paste)" & notify-send "downloading with yt-dlp...";;
    "download with curl") footclient -e curl "$(wl-paste)" & notify-send "downloading with curl...";;
    "git clone") footclient -e git clone "$(wl-paste)" & notify-send "cloning repo...";;
esac
