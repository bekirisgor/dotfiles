#!/bin/bash

# Dotfiles installation script for macOS
# This script sets up a new macOS system with your preferred tools and configurations

set -e # Exit immediately if a command exits with a non-zero status
set -u # Treat unset variables as an error when substituting

echo "🚀 Starting dotfiles installation..."

# Check if macOS
if [[ $(uname) != "Darwin" ]]; then
  echo "❌ This script is only for macOS"
  exit 1
fi

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Development"

# Install Xcode Command Line Tools if needed
if ! xcode-select -p &>/dev/null; then
  echo "🛠️ Installing Xcode Command Line Tools..."
  xcode-select --install
  # Wait for the installation to complete
  echo "Please wait for Xcode Command Line Tools to finish installing and press Enter to continue..."
  read -r
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to path based on architecture
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew already installed"
fi

# Install essential command-line tools
echo "🛠️ Installing command-line tools..."
brew install \
  git \
  gh \
  fish \
  neovim \
  tmux \
  ripgrep \
  fd \
  fzf \
  eza \
  chezmoi \
  jq \
  htop \
  btop \
  wget \
  curl \
  tldr \
  tree \
  ncftp

# Install window management tools
echo "🪟 Installing window management tools..."
brew install \
  yabai \
  skhd \
  sketchybar

# Install terminal and fonts
echo "⌨️ Installing terminal and fonts..."
brew install --cask alacritty
brew install --cask \
  font-hack-nerd-font \
  font-iosevka-nerd-font \
  font-iosevka-term-nerd-font \
  font-jetbrains-mono-nerd-font

# Install development tools and languages
echo "💻 Installing development tools and languages..."
brew install \
  go \
  node \
  yarn \
  pnpm \
  python \
  python@3.12 \
  python@3.13 \
  pyenv \
  uv \
  pipx \
  ruby \
  rye \
  sqlite \
  redis \
  postgresql@15

# Install Rust if not already installed
if ! command -v rustc &>/dev/null; then
  echo "🦀 Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "✅ Rust already installed"
fi

# Install Docker & Kubernetes tools
echo "🐳 Installing Docker and Kubernetes tools..."
brew install \
  colima \
  docker \
  docker-compose \
  kubernetes-cli

# Install applications
echo "📱 Installing applications..."
brew install --cask \
  google-chrome \
  spotify \
  discord \
  whatsapp \
  postman \
  visual-studio-code \
  cyberduck \
  iterm2 \
  rectangle \
  lm-studio \
  alfred \
  notion \
  slack

# Install global npm packages
echo "📦 Installing global npm packages..."
npm install -g \
  typescript \
  typescript-language-server \
  eslint \
  prettier

# Install cargo packages
echo "📦 Installing cargo packages..."
cargo install \
  code2prompt \
  ratisui

# Install database management tools
echo "🗄️ Installing database tools..."
brew install --cask redis-insight

# Install Claude CLI
echo "🤖 Installing Claude CLI..."
brew install claude

# Configure macOS
echo "⚙️ Configuring macOS settings..."

# General UI/UX
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Keyboard settings
# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
# Shorter delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 10
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Trackpad: enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Dock settings
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 48
# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Finder settings
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Show the ~/Library folder
chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Screenshots: save to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Restart affected applications
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" > /dev/null 2>&1 || true
done

# Setup Chezmoi
echo "🔄 Setting up dotfiles with Chezmoi..."
chezmoi init --apply bekirisgor/dotfiles

# Set Fish as default shell
if ! grep -q "$(which fish)" /etc/shells; then
  echo "🐠 Adding Fish to /etc/shells..."
  echo "$(which fish)" | sudo tee -a /etc/shells
fi

current_shell=$(dscl . -read ~/ UserShell | sed 's/UserShell: //')
if [[ "$current_shell" != "$(which fish)" ]]; then
  echo "🐠 Setting Fish as default shell..."
  chsh -s "$(which fish)"
fi

# Check and start services
echo "🔄 Starting services..."
brew services start yabai
brew services start skhd
brew services start sketchybar
brew services start redis
brew services start postgresql@15

# Create Colima VM for Docker
if ! colima ls 2>/dev/null | grep -q "Running"; then
  echo "🐳 Setting up Colima for Docker..."
  colima start --cpu 4 --memory 8 --disk 20
fi

echo "✅ Installation complete! Please restart your system to ensure all changes take effect."