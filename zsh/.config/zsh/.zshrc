autoload -U compinit promptinit
autoload -U colors && colors
autoload -U autosuggestions

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' menu select

setopt append_history inc_append_history share_history
setopt auto_menu menu_complete

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
source <(fzf --zsh)
if [[ $- != *i* ]] ; then
	return
fi

alias rm="trash"
alias vi="$EDITOR"
alias py="python"
alias em="emacs"
alias q="exit"
alias ls="ls --color=always"

# vi mode
bindkey -v
export KEYTIMEOUT=1
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with v:
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh 2>/dev/null


if [[ -z "$TMUX" ]]; then
  exec tmux new-session zsh
fi
