#!/bin/bash

# Update and upgrade Termux packages
pkg update -y && pkg upgrade -y

# Install necessary packages
pkg install -y zsh git python vim

# Install Oh My Zsh
# The --unattended option is used to prevent the installer from trying to run zsh
# at the end, which would fail in this non-interactive environment.
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed."
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# Setup storage access
termux-setup-storage

echo "Bootstrap complete. Please restart Termux and run the install.sh script."
