#!/bin/bash

# Get the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create symlinks
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DIR/.vimrc" "$HOME/.vimrc"

# Change default shell to zsh
if [ "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]; then
  chsh -s zsh
  echo "Default shell changed to zsh. Please restart Termux."
else
  echo "Default shell is already zsh."
fi

echo "Installation complete."
