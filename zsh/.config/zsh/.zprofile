# /etc/skel/.bash_profile

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/"${UID}"-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

export $(dbus-launch)

if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# XDG base dirs
#
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"


export XDG_DESKTOP_DIR="$HOME/.local/share/desktop/"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_PUBLICSHARE_DIR="$HOME/.local/share"
export XDG_TEMPLATES_DIR="$HOME/"
export XDG_VIDEOS_DIR="$HOME/media"
export XDG_PROJECTS_DIR="$HOME/docs/projects"

# misc
export ZDOTDIR=$HOME/.config/zsh
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store
export HISTFILE="$XDG_STATE_HOME/bash/history"
export SQLITE_HISTORY=$XDG_STATE_HOME/sqlite_history 
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_DATA_HOME/aspell/en.pws; repl $XDG_DATA_HOME/aspell/en.prepl"

# Programming Languages
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PNPM_HOME="$XDG_DATA_HOME"/pnpm

# Programs
export EDITOR="nvim"
export BROWSER="librewolf"
export OPENER="xdg-open"
export WINEPREFIX="$XDG_DATA_HOME"/wine

# Themes
#export GTK_THEME=""
#export GTK3_THEME=""
export QT_QPA_PLATFORMTHEME="qt6ct"

# PATH variable
export PATH="$HOME/.local/bin:$HOME/.local/share/python-venv/bin:/$HOME/.local/share/cargo/bin:$HOME/.local/share/go/bin:$HOME/.local/share/pnpm:/usr/local/texlive/2026/bin/x86_64-linux:$PNPM_HOME:$PATH"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startw
    exit
fi
