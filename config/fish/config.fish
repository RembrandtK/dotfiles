# Fish shell configuration

# Disable fish greeting
set -g fish_greeting

# If not running interactively, don't do anything
if not status is-interactive
    return
end

# Add custom bin directory to PATH
fish_add_path -p /git/RembrandtK/rem/bin

# Add Foundry to PATH if it exists
if test -d $HOME/.foundry/bin
    fish_add_path -p $HOME/.foundry/bin
end

# Source private configs if available
set -l private_config /git/RembrandtK/rem/config/shell/private-fish-config.fish
if test -f $private_config
    source $private_config
end

# System status on startup only when attached to a real TTY (avoid VS Code probes)
if test -t 1
    set -l system_status /git/RembrandtK/rem/bin/system-status.sh
    if test -x $system_status
        $system_status
    end
end

# Common aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias gb='git branch'
alias gco='git checkout'

# Development aliases
alias code='code .'
alias serve='python3 -m http.server'

# System aliases
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'

# ZFS management aliases (machine-specific, not in dotfiles)
if test -f /git/RembrandtK/rem/config/machine/pms/zfs/root/zfs/fish-aliases.fish
    source /git/RembrandtK/rem/config/machine/pms/zfs/root/zfs/fish-aliases.fish
end
