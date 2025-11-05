#!/bin/bash
# Dotfiles installation script for VS Code dev containers

set -e

echo "🐟 Setting up dotfiles..."

# Get the directory where this script is located (dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# In dev containers, prefer /git/RembrandtK/dotfiles if it exists
# This avoids unnecessary clones and ensures using the mounted version
if [ -d "/git/RembrandtK/dotfiles" ] && [ "$DOTFILES_DIR" != "/git/RembrandtK/dotfiles" ]; then
    echo "🔗 Using mounted dotfiles at /git/RembrandtK/dotfiles"
    DOTFILES_DIR="/git/RembrandtK/dotfiles"

    # Create symlink at ~/dotfiles for convenience
    if [ ! -L "$HOME/dotfiles" ] || [ "$(readlink -f "$HOME/dotfiles")" != "/git/RembrandtK/dotfiles" ]; then
        rm -rf "$HOME/dotfiles" 2>/dev/null || true
        ln -sf "/git/RembrandtK/dotfiles" "$HOME/dotfiles"
        echo "✅ Created ~/dotfiles symlink"
    fi
fi

# Auto-update dotfiles if it's a git repo
if [ -d "$DOTFILES_DIR/.git" ]; then
    cd "$DOTFILES_DIR"
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
        echo "⚠️  Warning: Uncommitted changes in dotfiles repo"
        git status --short
    else
        echo "🔄 Checking for dotfiles updates..."
        git pull --quiet 2>/dev/null && echo "✅ Dotfiles up to date" || true
    fi
    cd - > /dev/null
fi

# Create symlinks for shell configs
echo "🔗 Creating symlinks for shell configurations..."

# Function to safely create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    if [ -f "$source" ]; then
        # Remove existing file/symlink
        [ -e "$target" ] && rm "$target"
        ln -sf "$source" "$target"
        echo "✅ Symlinked $name"
    fi
}

# Create symlinks for shell configs
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc" ".bashrc"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" ".zshrc"
create_symlink "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases" ".bash_aliases"

# Symlink fish configuration
echo "🐟 Setting up fish shell..."
if [ -d "$DOTFILES_DIR/config/fish" ]; then
    # Remove existing fish config directory
    [ -d "$HOME/.config/fish" ] && rm -rf "$HOME/.config/fish"
    # Create parent directory and symlink the entire fish config
    mkdir -p "$HOME/.config"
    ln -sf "$DOTFILES_DIR/config/fish" "$HOME/.config/fish"
    echo "✅ Symlinked fish configuration"
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

# Set fish as default shell (skip in dev containers where Dockerfile handles it)
if command -v fish &> /dev/null; then
    if [ "$REMOTE_CONTAINERS" != "true" ] && [ ! -f "/.dockerenv" ]; then
        FISH_PATH="$(which fish)"
        if [ "$SHELL" != "$FISH_PATH" ]; then
            echo "🐟 Setting fish as default shell..."
            if chsh -s "$FISH_PATH" 2>/dev/null; then
                echo "✅ Fish set as default shell (restart terminal to apply)"
            else
                echo "⚠️  Could not change default shell. Run: chsh -s \$(which fish)"
            fi
        fi
    fi
fi

# Link shared devcontainer files if in a dev container
if [ "$REMOTE_CONTAINERS" = "true" ] || [ -f "/.dockerenv" ]; then
    SHARED_FILES_DIR="/git/RembrandtK/devcontainers/work"
    TARGET_DIR="/work"

    if [ -d "$SHARED_FILES_DIR" ] && [ -d "$TARGET_DIR" ]; then
        echo "🔗 Linking shared devcontainer files..."
        sudo mkdir -p "$TARGET_DIR" 2>/dev/null || true
        sudo chown vscode:vscode "$TARGET_DIR" 2>/dev/null || true

        for file in "$SHARED_FILES_DIR"/*; do
            [ ! -f "$file" ] && continue

            filename=$(basename "$file")
            target="$TARGET_DIR/$filename"

            # Skip if already correctly linked
            [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$file")" ] && continue

            # Skip if user file exists
            [ -e "$target" ] && [ ! -L "$target" ] && continue

            # Remove stale symlink and create new one
            [ -L "$target" ] && rm "$target"
            ln -s "$file" "$target"
        done

        echo "✅ Linked shared files from $SHARED_FILES_DIR"
    fi
fi

echo "🎉 Dotfiles installation complete!"
echo ""
echo "🔗 All configurations are now symlinked to ~/dotfiles/"
echo "   Changes to dotfiles repo will be immediately reflected"
echo ""
echo "💡 To use fish shell:"
echo "   fish"
echo ""
echo "💡 To test system status (if available):"
echo "   sysstatus"
echo ""
echo "💡 Available aliases: gs, gd, gc, gp, gl, ll, la, ..."
