# Skip interactive setup for scripts and other non-interactive shells.
if [[ $- != *i* ]]; then
  return
fi

# Enable Powerlevel10k instant prompt before other startup work.
[[ -t 1 ]] && printf '\e[5 q'
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit promptinit
autoload -U colors && colors
autoload -U autosuggestions
#autoload -U p10k

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

compinit
#promptinit; prompt walters
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' menu select

setopt append_history inc_append_history share_history
setopt auto_menu menu_complete

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
source <(fzf --zsh)

alias rm="trash"
alias vi="$EDITOR"
alias py="python"
alias em="emacs"
alias q="exit"
alias ls="ls --color=always"
alias ff='fastfetch'

# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


