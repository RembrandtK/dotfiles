# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Set colorful prompt
if [ "$color_prompt" != no ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

# Load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source private configs if available
if [ -f "/git/RembrandtK/rem/config/shell/private-bash-config.sh" ]; then
    source "/git/RembrandtK/rem/config/shell/private-bash-config.sh"
fi

# Source cargo environment if available
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Add CONTAINER_BIN_PATH to PATH if set
if [ -n "${CONTAINER_BIN_PATH:-}" ]; then
  export PATH="$CONTAINER_BIN_PATH:$PATH"
fi

# ZFS management aliases (machine-specific, not in dotfiles)
source /git/RembrandtK/rem/config/machine/pms/zfs/root/zfs/bash-aliases.sh

# Created by `pipx` on 2025-12-23 16:24:34
export PATH="$PATH:/home/rem/.local/bin"
