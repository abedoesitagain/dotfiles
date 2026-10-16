if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/"${UID}"-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

export $(dbus-launch)

# XDG base dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# XDG user dirs
export XDG_DESKTOP_DIR="$HOME/.local/share/desktop/"
export XDG_PUBLICSHARE_DIR="$HOME/.local/share"
export XDG_TEMPLATES_DIR="$HOME/.local/share/templates/"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_VIDEOS_DIR="$HOME/media"
export XDG_PROJECTS_DIR="$HOME/docs/projects"

# misc dirs
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_DATA_HOME/aspell/en.pws; repl $XDG_DATA_HOME/aspell/en.prepl"
export WINEPREFIX="$XDG_DATA_HOME/wine"

# Programming Language dirs
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
#export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export CODEX_HOME="$XDG_DATA_HOME/codex"

# Program params
export EDITOR="nvim"
export BROWSER="librewolf"
export OPENER="xdg-open"

# Themes
# export GTK_THEME=""           # Handled by darkman
# export GTK3_THEME=""
export QT_QPA_PLATFORMTHEME="gtk3"

# PATH variable
export PATH="$HOME/.local/bin:$HOME/.local/share/python-venv/bin:/$HOME/.local/share/cargo/bin:$HOME/.local/share/go/bin:$HOME/.local/share/pnpm:/usr/local/texlive/2026/bin/x86_64-linux:$PNPM_HOME:$PATH"

[[ -f ~/.local/share/Xresources/Xresources ]] && xrdb -merge -I$HOME ~/.local/share/Xresources/Xresources

# autostart at tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    DISPLAY=':0'
    startw
    exit
fi
