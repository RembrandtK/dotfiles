# dotfiles

Multi-shell dotfiles configuration with fish shell focus and private configuration integration.

## Features

- **Fish shell** (primary): Full configuration with system status integration
- **Bash/Zsh** (compatibility): Clean, minimal configurations
- **Shared aliases**: Consistent across all shells
- **Private config integration**: Sources private configurations when available
- **VS Code dev container ready**: Automatic setup in development containers
- **Symlinked configs**: Live updates without reinstallation
- **Git Configuration**: Pre-configured git settings with useful aliases and VS Code integration

## Shell Support

### Fish Shell (Primary)
- Custom configuration with system status on startup
- Function library including `sysstatus`
- Sources private config from `/git/RembrandtK/rem/config/shell/private-fish-config.fish`

### Bash
- Clean configuration sourcing `.bash_aliases`
- Sources private config from `/git/RembrandtK/rem/config/shell/private-bash-config.sh`

### Zsh
- Completion and color support
- Sources private config from `/git/RembrandtK/rem/config/shell/private-zsh-config.zsh`

## Installation

### VS Code Dev Containers (Automatic)
This repository is configured to work automatically with VS Code dev containers. Add to your VS Code settings:

```json
{
  "dotfiles.repository": "RembrandtK/dotfiles"
}
```

When you open a project with a `.devcontainer` configuration, the dotfiles will be automatically cloned and installed.

### Manual Installation (Standard Pattern)
For other environments (host system, SSH servers, regular containers):

```bash
# Clone to standard location
git clone https://github.com/RembrandtK/dotfiles.git /git/RembrandtK/dotfiles

# Create symlink to home directory
ln -sf /git/RembrandtK/dotfiles ~/dotfiles

# Run installation script
~/dotfiles/install.sh
```

This pattern ensures:
- **Consistent location**: `/git/RembrandtK/dotfiles` across all systems
- **Easy access**: `~/dotfiles` symlink for convenience
- **Live updates**: Changes to repo immediately reflected in shell

### Alternative Quick Install
For temporary or testing environments:

```bash
git clone https://github.com/RembrandtK/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Private Configuration Integration

This public dotfiles repository can optionally source private configurations:

- **Fish**: `/git/RembrandtK/rem/config/shell/private-fish-config.fish`
- **Bash**: `/git/RembrandtK/rem/config/shell/private-bash-config.sh`
- **Zsh**: `/git/RembrandtK/rem/config/shell/private-zsh-config.zsh`

If these files exist, they will be automatically sourced. If not, the dotfiles work perfectly without them. This allows sensitive configurations (API keys, private aliases) to be kept separate while still being integrated seamlessly.

## Configuration Files

### .gitconfig
- VS Code integration for editing and merging
- Comprehensive git aliases
- SSH signing support
- Automatic remote tracking

### Fish Configuration
- System status on startup showing storage and memory utilization
- Comprehensive aliases for development
- Private configuration integration
- Custom functions (e.g., `sysstatus`)

### Shell Aliases
- Common file operations (`ll`, `la`, `..`)
- Git shortcuts (`gs`, `gd`, `gc`, `gp`)
- Development tools (`serve`, system monitoring)
- Consistent across bash, zsh, and fish

## System Status Integration

When available, the fish shell will display system status on startup showing storage and memory utilization with color-coded indicators:

```
💾 ✓ Storage: 36% max drive utilisation
🧠 ✓ Memory: 22% used (10Gi/47Gi)
```
