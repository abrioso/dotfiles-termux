#!/usr/bin/env bash
# bootstrap.sh — First-run setup for a fresh Termux install
# Usage: bash bootstrap.sh [--skip-storage]
#   --skip-storage  Do not request Android storage access (termux-setup-storage)
#
# Installs the packages listed in packages.txt, Oh My Zsh and its plugins, then
# runs install.sh to link the dotfiles. Restart Termux when it finishes.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_STORAGE=true

for arg in "$@"; do
    case "$arg" in
        --skip-storage) SETUP_STORAGE=false ;;
        --help|-h)
            sed -n '2,7p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg" >&2
            exit 2
            ;;
    esac
done

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }
success() { printf '\033[1;32m[ OK ]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$1"; }
error() { printf '\033[1;31m[ERROR]\033[0m %s\n' "$1" >&2; }

if ! command -v pkg >/dev/null 2>&1; then
    error "This script must run inside Termux (pkg not found)."
    exit 1
fi

# Update and upgrade Termux packages
info "Updating Termux packages..."
pkg update -y && pkg upgrade -y
success "Packages are up to date."

# Install packages from list (comments and blank lines are ignored)
PKG_FILE="$SCRIPT_DIR/packages.txt"
packages=()
if [ -f "$PKG_FILE" ]; then
    while IFS= read -r line; do
        line="${line%%#*}"
        line="${line// /}"
        [ -z "$line" ] && continue
        packages+=("$line")
    done < "$PKG_FILE"
fi
if [ ${#packages[@]} -eq 0 ]; then
    warn "packages.txt missing or empty; installing the essentials instead."
    packages=(zsh git python vim nodejs npm gh htop tmux ripgrep wget curl openssh ffmpeg imagemagick rclone)
fi
info "Installing ${#packages[@]} packages..."
pkg install -y "${packages[@]}" || {
    warn "Some packages failed; installing one by one..."
    for pkg_name in "${packages[@]}"; do
        pkg install -y "$pkg_name" || warn "Failed: $pkg_name"
    done
}
success "Packages installed."

# Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    info "Oh My Zsh already installed."
else
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Zsh plugins (same set as dotfiles-linux)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    info "Installing zsh-autosuggestions..."
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    info "Installing zsh-syntax-highlighting..."
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
success "Oh My Zsh and plugins ready."

# Storage access (shows an Android permission dialog on first run)
if [ "$SETUP_STORAGE" = true ]; then
    if [ -d "$HOME/storage" ]; then
        info "Storage access already configured."
    else
        info "Requesting storage access..."
        termux-setup-storage || warn "termux-setup-storage failed; run it manually later."
    fi
fi

# Link dotfiles (prompts for the Git identity unless GIT_USER_NAME/GIT_USER_EMAIL
# are exported or git already knows it)
info "Installing dotfiles..."
"$SCRIPT_DIR/install.sh"
success "Dotfiles installed."

echo ""
success "Bootstrap complete! Restart Termux to start using zsh."
