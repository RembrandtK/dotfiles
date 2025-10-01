#!/bin/bash
# install.sh - Dotfiles installation script for VS Code dev containers

set -e

echo "Installing dotfiles..."

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to create symlink if it doesn't exist or is different
link_file() {
    local src="$1"
    local dest="$2"
    
    if [ -L "$dest" ]; then
        # Remove existing symlink
        rm "$dest"
    elif [ -f "$dest" ]; then
        # Backup existing file
        echo "Backing up existing $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi
    
    echo "Linking $src -> $dest"
    ln -sf "$src" "$dest"
}

# Link configuration files
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "Dotfiles installation complete!"
echo ""
echo "Note: Git user name and email are not configured in .gitconfig"
echo "You can configure them in VS Code settings or by running:"
echo "  git config --global user.name \"Your Name\""
echo "  git config --global user.email \"your.email@example.com\""
