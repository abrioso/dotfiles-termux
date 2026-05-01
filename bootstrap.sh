#!/bin/bash

# Update and upgrade Termux packages
pkg update -y && pkg upgrade -y

# Install packages from list
if [ -f "$(dirname "$0")/packages.txt" ]; then
  echo "Installing packages from packages.txt..."
  xargs -a "$(dirname "$0")/packages.txt" pkg install -y
else
  # Fallback: install essentials
  pkg install -y zsh git python vim nodejs npm gh htop tmux ripgrep wget curl openssh ffmpeg imagemagick rclone
fi

# Install Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed."
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Setup storage access
termux-setup-storage

echo "Bootstrap complete. Please restart Termux and run install.sh"
