#!/bin/bash
# Dotfiles installation script for VS Code dev containers

set -e

echo "🐟 Setting up dotfiles..."

# Get the directory where this script is located (dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup and install shell configs
echo "📝 Installing shell configurations..."

# Install bash config (force overwrite)
if [ -f "$DOTFILES_DIR/.bashrc" ]; then
    cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    echo "✅ Installed .bashrc"
fi

# Install zsh config (force overwrite)
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    echo "✅ Installed .zshrc"
fi

# Install bash aliases
if [ -f "$DOTFILES_DIR/.bash_aliases" ]; then
    cp "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
    echo "✅ Installed .bash_aliases"
fi

# Install fish configuration
echo "🐟 Setting up fish shell..."
if [ -d "$DOTFILES_DIR/config/fish" ]; then
    mkdir -p "$HOME/.config/fish"
    cp -r "$DOTFILES_DIR/config/fish/"* "$HOME/.config/fish/"
    echo "✅ Installed fish configuration"
fi

# Git config should already be handled by VS Code dotfiles
if [ -f "$HOME/.gitconfig" ]; then
    echo "✅ Git configuration already present"
fi

# Install fish shell if not present
if ! command -v fish &> /dev/null; then
    echo "🐟 Installing fish shell..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y fish
    elif command -v apk &> /dev/null; then
        sudo apk add fish
    else
        echo "⚠️  Could not install fish shell automatically"
    fi
fi

echo "🎉 Dotfiles installation complete!"
echo ""
echo "💡 To use fish shell:"
echo "   fish"
echo ""
echo "💡 To test system status (if available):"
echo "   sysstatus"
echo ""
echo "💡 Available aliases: gs, gd, gc, gp, gl, ll, la, ..."
