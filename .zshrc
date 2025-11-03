# ~/.zshrc: executed by zsh for interactive shells.

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory sharehistory incappendhistory

# Enable colors and completion
autoload -U colors && colors
autoload -Uz compinit && compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colorful prompt
PS1='%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$ '

# Enable color support
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Key bindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Load aliases
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

# Source private configs if available
if [[ -f "/git/RembrandtK/rem/config/shell/private-zsh-config.zsh" ]]; then
    source "/git/RembrandtK/rem/config/shell/private-zsh-config.zsh"
fi
