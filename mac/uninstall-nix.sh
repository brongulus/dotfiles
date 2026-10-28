#!/usr/bin/env bash
set -e

echo "=== Nix + nix-darwin Uninstaller ==="
echo "This script will remove nix-darwin, Nix, and all related files."
echo ""
read -r -p "Continue? [y/N] " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }

########################################
# STEP 1: Uninstall nix-darwin
########################################
echo ""
echo "[1/4] Uninstalling nix-darwin..."
 
if command -v darwin-rebuild >/dev/null 2>&1 || [[ -f /run/current-system/sw/bin/darwin-rebuild ]]; then
    if ! sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller; then
    echo ""
    echo "WARNING: nix-darwin uninstaller failed or exited non-zero."
    echo "Continuing may leave nix-darwin hooks in place and cause the Nix uninstaller to fail."
    read -r -p "Continue anyway? [y/N] " proceed
    [[ "$proceed" =~ ^[Yy]$ ]] || { echo "Aborted. Fix nix-darwin manually and re-run."; exit 1; }
  fi
else
  echo "nix-darwin not found or already removed, skipping."
fi

########################################
# STEP 2: Uninstall nix
########################################
echo ""
echo "[2/4] Removing Nix files and directories..."

sudo rm -rf /nix
sudo rm -rf /etc/nix
rm -rf ~/.config/nix
rm -rf ~/.nix-profile
rm -rf ~/.nix-defexpr
rm -rf ~/.nix-channels

# nix-darwin state
sudo rm -rf /run/current-system
sudo rm -rf /etc/static

########################################
# STEP 3: Remove nix daemon + build users
########################################
echo ""
echo "[3/4] Removing Nix daemon and build users..."

sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true
sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist

for i in $(seq 1 32); do
  sudo dscl . -delete /Users/_nixbld$i 2>/dev/null || true
done
sudo dscl . -delete /Groups/nixbld 2>/dev/null || true

########################################
# STEP 4: Restore /etc shell configs
########################################
echo ""
echo "[4/4] Restoring /etc shell configs modified by nix-darwin..."

for f in /etc/zshrc /etc/bashrc /etc/bash.bashrc /etc/shells; do
  if [[ -f "${f}.before-nix-darwin" ]]; then
    echo "  Restoring ${f} from backup..."
    sudo mv "${f}.before-nix-darwin" "$f"
  fi
done

# Strip nix-injected blocks from /etc/zshrc and /etc/bashrc if still present
for f in /etc/zshrc /etc/bashrc; do
  if [[ -f "$f" ]] && grep -q "nix" "$f" 2>/dev/null; then
    echo "  Removing Nix lines from ${f}..."
    sudo sed -i.bak '/# Nix/,/# End Nix/d' "$f"
    sudo sed -i.bak '/\/nix\//d' "$f"
  fi
done

# Strip nix lines from personal dotfiles
# for f in "$HOME/.zshrc" "$HOME/.bashrc" "$HOME/.config/fish/config.fish"; do
#   if [[ -f "$f" ]] && grep -q "nix" "$f" 2>/dev/null; then
#     echo "  Removing Nix lines from ${f}..."
#     sed -i.bak '/# Nix/,/# End Nix/d' "$f"
#     sed -i.bak '/\/nix\//d' "$f"
#   fi
# done

########################################
# DONE
########################################
echo ""
echo "Done! Open a new terminal and verify with: which nix"
echo "Then run install.sh to set up your new environment."
