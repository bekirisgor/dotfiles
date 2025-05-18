# Dotfiles

My personal dotfiles managed with [Chezmoi](https://www.chezmoi.io/).

## File Structure

This repository uses a natural file naming structure:

- `.config/` - Configuration files that go in ~/.config
- `.tmux/` - Tmux plugins and configuration
- `.tmux.conf` - Tmux configuration file
- `.claude/` - Claude AI configuration
- `.gitconfig` - Git configuration
- `.zshrc` - Zsh shell configuration

## Installation

To set up these dotfiles on a new machine:

```bash
# Option 1: Quick install script
curl -fsSL https://raw.githubusercontent.com/bekirisgor/dotfiles/main/install.sh | bash

# Option 2: Manual setup with Chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bekirisgor
```

## What's Included

- Window management with Yabai, SKHD, and Sketchybar
- Terminal configuration with Fish shell, Tmux, and Alacritty
- Neovim configuration
- Git configuration
- macOS system preferences
- Essential development tools

## Customization

After installing, you can update the configurations using Chezmoi:

```bash
# Make changes to a file
chezmoi edit ~/.zshrc

# Apply changes
chezmoi apply

# Update from repository
chezmoi update
```