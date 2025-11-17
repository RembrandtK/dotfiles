# Fish shell configuration

# Disable fish greeting
set -g fish_greeting

# Add custom bin directory to PATH
fish_add_path -p /git/RembrandtK/rem/bin

# Add Foundry to PATH if it exists
if test -d $HOME/.foundry/bin
    fish_add_path -p $HOME/.foundry/bin
end

if status is-interactive
    # Source private configs if available
    set -l private_config /git/RembrandtK/rem/config/shell/private-fish-config.fish
    if test -f $private_config
        source $private_config
    end
    
    # System status on startup if available
    set -l system_status /git/RembrandtK/rem/bin/system-status.sh
    if test -x $system_status
        $system_status
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
end
