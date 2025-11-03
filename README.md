# dotfiles

Multi-shell configuration files for development environments

This repository contains dotfiles that provide consistent shell configurations, git settings, and editor preferences across development environments, with support for bash, zsh, and fish shells.

## Features

- **Multi-shell support**: Bash, Zsh, and Fish configurations
- **Git Configuration**: Pre-configured git settings with useful aliases and VS Code integration
- **Private config integration**: References private configurations when available
- **VS Code dev container ready**: Automatic setup in development containers
- **Editor Configuration**: Consistent coding styles across editors

## Shell Support

### Fish Shell (Primary)
- **Config**: `config/fish/config.fish`
- **Functions**: `config/fish/functions/`
- **Features**: System status integration, comprehensive aliases, private config sourcing

### Bash/Zsh (Compatibility)
- **Bash**: `.bashrc` with clean, minimal configuration
- **Zsh**: `.zshrc` with completion and colors
- **Shared aliases**: `.bash_aliases` for common commands

## Usage

### VS Code Dev Containers

Add to your VS Code settings:

```json
{
  "dotfiles.repository": "RembrandtK/dotfiles"
}
```

### Manual Installation

Fish shell users should symlink the fish config:

```bash
ln -sf /path/to/dotfiles/config/fish ~/.config/fish
```

## Private Configuration Integration

These dotfiles can source private configurations when available:

- **Fish**: Sources `/git/RembrandtK/rem/config/shell/private-fish-config.fish`
- **Bash**: Sources `/git/RembrandtK/rem/config/shell/private-bash-config.sh`
- **Zsh**: Sources `/git/RembrandtK/rem/config/shell/private-zsh-config.zsh`

This allows sensitive configurations (API keys, private aliases) to be kept separate while still being integrated seamlessly.

## Configuration Files

### .gitconfig
- VS Code integration for editing and merging
- Comprehensive git aliases
- SSH signing support
- Automatic remote tracking

### Fish Configuration
- System status on startup
- Comprehensive aliases for development
- Private configuration integration
- Custom functions (e.g., `sysstatus`)

### Shell Aliases
- Common file operations (`ll`, `la`, `..`)
- Git shortcuts (`gs`, `gd`, `gc`, `gp`)
- Development tools (`serve`, system monitoring)
- Consistent across bash, zsh, and fish
