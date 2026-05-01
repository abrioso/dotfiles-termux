# dotfiles-termux

Dotfiles and setup scripts for my Termux environment on Android.

## What's included

- `.zshrc` — Zsh config with Oh My Zsh (af-magic theme)
- `.vimrc` — Vim config (syntax, line numbers, 4-space tabs, mouse)
- `.termux.properties` — Termux terminal settings
- `.colors.properties` — Color theme
- `.font.ttf` — Nerd Font for terminal
- `bin/` — Custom scripts (mp4checkfix utilities)
- `packages.txt` — List of manually installed packages
- `bootstrap.sh` — First-run: installs packages + Oh My Zsh
- `install.sh` — Symlinks dotfiles into place

## Setup on a fresh Termux

```bash
pkg install git -y
git clone https://github.com/abrioso/dotfiles-termux.git
cd dotfiles-termux
bash bootstrap.sh
# restart Termux
bash install.sh
# restart Termux
```

## Updating this repo

From the cloned repo, run:
```bash
cp ~/.zshrc .zshrc
cp ~/.vimrc .vimrc
cp ~/.termux/termux.properties .termux.properties
cp ~/.termux/colors.properties .colors.properties
cp ~/.termux/font.ttf .font.ttf
pkg list-installed 2>/dev/null | grep -v automatic | grep installed | awk -F/ '{print $1}' | sort > packages.txt
git add -A && git commit -m "Update dotfiles" && git push
```
