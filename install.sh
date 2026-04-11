#!/usr/bin/env bash
set -e

# echo "Installing brew packages"
# brew bundle --file="$(dirname "$0")/Brewfile"
# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Homebrew ready: $(brew --version)"

# Ensure brew is in PATH (important on Apple Silicon)
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Install kanata (brew doesn't have cmd support)
curl -L https://github.com/jtroo/kanata/releases/latest/download/kanata_cmd_allowed \
     -o /tmp/kanata_cmd_allowed
sudo mv /tmp/kanata_cmd_allowed /usr/local/bin/kanata
chmod +x /usr/local/bin/kanata

echo "Applying macOS system preferences..."
########################################
# SUDO / PAM (Touch ID for sudo)
########################################
if ! grep -q "pam_reattach" /etc/pam.d/sudo_local 2>/dev/null; then
  echo "Enabling Touch ID for sudo in tmux..."
  sudo tee /etc/pam.d/sudo_local << 'EOF'
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
EOF
fi

defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock show-recents -bool false
killall Dock || true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
killall Finder || true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.AdLib forceLimitAdTracking -bool true
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.AdLib allowIdentifierForAdvertising -bool false

echo "Restarting affected services..."
killall SystemUIServer || true
echo "Done! Some changes may require logout/restart."
