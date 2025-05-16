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
  visual-studio-code

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

# Set interface to dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Disable menu bar transparency
defaults write NSGlobalDomain AppleReduceDesktopTinting -bool false
# Hide menu bar
defaults write NSGlobalDomain "_HIHideMenuBar" -bool true

# Language and locale settings
defaults write NSGlobalDomain AppleLanguages -array "en-TR" "tr-TR"
defaults write NSGlobalDomain AppleLocale -string "en_TR"

# Keyboard settings
# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
# Shorter delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 10
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set function keys to standard function keys
defaults write NSGlobalDomain "com.apple.keyboard.fnState" -bool true

# Mouse and trackpad settings
# Disable mouse acceleration
defaults write NSGlobalDomain "com.apple.mouse.scaling" -float -1
# Set scroll wheel speed
defaults write NSGlobalDomain "com.apple.scrollwheel.scaling" -float 0.3125
# Set trackpad speed
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -int 1
# Set double-click threshold
defaults write NSGlobalDomain "com.apple.mouse.doubleClickThreshold" -float 0.8
# Disable force click
defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -bool false
# Enable natural scrolling
defaults write NSGlobalDomain "com.apple.swipescrolldirection" -bool true
# Enable tap to click
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
# Add hot corner for Mission Control (bottom right)
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0
# Disable launch animation
defaults write com.apple.dock launchanim -bool false

# Finder settings
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show all hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Disable all animations
defaults write com.apple.finder DisableAllAnimations -bool true
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Show the ~/Library folder
chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes
# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Animation and performance optimizations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSScrollAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false
defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write NSGlobalDomain NSToolbarFullScreenAnimationDuration -float 0
defaults write NSGlobalDomain NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0

# Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0

# Mail animations
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true

# Disable text autocorrection, substitution, and completion
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

# File management
defaults write NSGlobalDomain "com.apple.springing.enabled" -bool false
defaults write NSGlobalDomain "com.apple.springing.delay" -float 0.5

# Sound
defaults write NSGlobalDomain "com.apple.sound.beep.volume" -float 0.4540837
defaults write NSGlobalDomain "com.apple.sound.beep.flash" -bool false

# Screenshots: save to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Privacy: don't send new file warning to Apple
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Restart affected applications
for app in "Dock" "Finder" "Mail" "SystemUIServer"; do
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