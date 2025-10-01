# dotfiles
Configuration files for VS Code dev containers

This repository contains dotfiles that will be automatically applied to VS Code dev containers, providing consistent git configuration, shell settings, and editor preferences across all your development environments.

## Features

- **Git Configuration** (`.gitconfig`): Pre-configured git settings with useful aliases and VS Code integration
- **Bash Configuration** (`.bashrc`): Enhanced bash shell with colors, aliases, and better history management
- **Zsh Configuration** (`.zshrc`): Zsh shell configuration with completion, colors, and useful aliases
- **Automatic Installation** (`install.sh`): Script that symlinks configuration files to your home directory

## Usage

### Automatic Setup in VS Code

1. Open VS Code Settings (JSON) by pressing `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac) and selecting "Preferences: Open User Settings (JSON)"

2. Add the following configuration:

```json
{
  "dotfiles.repository": "RembrandtK/dotfiles",
  "dotfiles.targetPath": "~/dotfiles",
  "dotfiles.installCommand": "~/dotfiles/install.sh"
}
```

3. When you open a dev container, VS Code will automatically:
   - Clone this repository
   - Run the `install.sh` script
   - Apply all configuration files

### Manual Installation

If you want to install the dotfiles manually in any environment:

```bash
git clone https://github.com/RembrandtK/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Configuration Files

### .gitconfig

Provides:
- VS Code as default editor and diff/merge tool
- Useful git aliases (`st`, `co`, `br`, `ci`, `lg`, etc.)
- Better log formatting
- Automatic remote tracking
- Note: User name and email must be configured separately

### .bashrc

Provides:
- Colorized prompt
- Enhanced command history
- Useful aliases for common commands
- Git shortcuts
- Auto-completion support

### .zshrc

Provides:
- Colorized prompt
- Enhanced command history with sharing
- Case-insensitive completion
- Useful aliases for common commands
- Git shortcuts

## Customization

You can override any settings locally by creating additional configuration files:
- For git: Edit `~/.gitconfig` directly or use `git config --global`
- For bash: Create `~/.bash_profile` or `~/.bash_aliases`
- For zsh: Create `~/.zshenv` or add to `~/.zshrc`

## Git User Configuration

The `.gitconfig` file does not include user name and email. Configure them using:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Or add them to your VS Code settings:

```json
{
  "terminal.integrated.env.linux": {
    "GIT_AUTHOR_NAME": "Your Name",
    "GIT_AUTHOR_EMAIL": "your.email@example.com",
    "GIT_COMMITTER_NAME": "Your Name",
    "GIT_COMMITTER_EMAIL": "your.email@example.com"
  }
}
```
