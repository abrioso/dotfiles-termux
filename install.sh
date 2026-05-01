#!/bin/bash

# Get the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create symlinks for dotfiles
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DIR/.vimrc" "$HOME/.vimrc"

# Setup .termux directory
mkdir -p "$HOME/.termux"
ln -sf "$DIR/.termux.properties" "$HOME/.termux/termux.properties"
ln -sf "$DIR/.colors.properties" "$HOME/.termux/colors.properties"

# Copy font (symlinks don't work well for font.ttf)
if [ -f "$DIR/.font.ttf" ]; then
  cp "$DIR/.font.ttf" "$HOME/.termux/font.ttf"
fi

# Setup bin directory
mkdir -p "$HOME/bin"
if [ -d "$DIR/bin" ]; then
  for script in "$DIR/bin/"*; do
    ln -sf "$script" "$HOME/bin/$(basename "$script")"
  done
fi

# Change default shell to zsh
if [ "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]; then
  chsh -s zsh
  echo "Default shell changed to zsh. Please restart Termux."
else
  echo "Default shell is already zsh."
fi

# Reload termux settings
termux-reload-settings 2>/dev/null

echo "Installation complete."
