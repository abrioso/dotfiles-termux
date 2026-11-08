# 📱 dotfiles-termux

![Shell](https://img.shields.io/badge/shell-zsh-green)
![OS](https://img.shields.io/badge/OS-Android%20Termux-blue)
![License](https://img.shields.io/badge/license-MIT-yellow)

Dotfiles and setup scripts for my [Termux](https://termux.dev/) environment on Android. The shell,
editor and Git configuration are kept in step with
[dotfiles-linux](https://github.com/abrioso/dotfiles-linux).

## 📦 What's Included

```
dotfiles-termux/
├── bootstrap.sh            # One-command setup (packages, Oh My Zsh, dotfiles)
├── install.sh              # Symlinks dotfiles into place (with backups)
├── .zshrc                  # Zsh config (Oh My Zsh, af-magic, shared aliases)
├── .vimrc                  # Vim config (same as dotfiles-linux)
├── .gitconfig              # Shared Git defaults; identity goes to ~/.gitconfig.local
├── .termux.properties      # Termux terminal settings
├── .colors.properties      # Color theme
├── .font.ttf               # Nerd Font for the terminal
├── bin/                    # Custom scripts (mp4checkfix), linked into ~/bin
├── packages.txt            # Explicitly installed Termux packages
├── scripts/                # Helper scripts (export-packages.sh)
├── git-hooks/              # Gitflow pre-commit/pre-push hooks (shared with dotfiles-windows)
├── tests/validate.sh       # Local + CI validation (bash -n, shellcheck, Python parse)
└── docs/                   # Documentation
```

## 🚀 Quick Start

On a fresh Termux install:

```bash
pkg install git -y
git clone https://github.com/abrioso/dotfiles-termux.git ~/dotfiles-termux
cd ~/dotfiles-termux
bash bootstrap.sh
# restart Termux
```

`bootstrap.sh` updates Termux, installs every package in `packages.txt`, installs Oh My Zsh with
the autosuggestions and syntax-highlighting plugins, requests storage access, and finally runs
`install.sh`, which asks for your Git identity unless `GIT_USER_NAME`/`GIT_USER_EMAIL` are
exported. Pass `--skip-storage` to skip the Android storage permission dialog.

## 🔧 Manual Steps

1. **Install dotfiles only** (no packages):
   ```bash
   bash install.sh
   ```

2. **Dry run** (see what would change):
   ```bash
   bash install.sh --dry-run
   ```

3. **Force install** (never prompts; the Git identity is taken from `GIT_USER_NAME` /
   `GIT_USER_EMAIL` or from the existing git config, otherwise left for you to set):
   ```bash
   GIT_USER_NAME="Your Name" GIT_USER_EMAIL="you@example.com" bash install.sh --force
   ```

Existing regular files that would be replaced are moved to `~/.dotfiles-backup/<timestamp>`.

## ⚙️ Customization

- Add local overrides in `~/.zshrc.local` (sourced automatically)
- Git identity and other machine-specific Git settings live in `~/.gitconfig.local`, created by
  `install.sh` on first run (prompting, or from `GIT_USER_NAME`/`GIT_USER_EMAIL`, or from the
  identity git already resolves) and included by the tracked `.gitconfig`; the tracked file never
  changes on a device
- Add custom scripts to `bin/`; `install.sh` links them into `~/bin`, which `.zshrc` puts on `PATH`

## 🔄 Updating this repo

The dotfiles are symlinked, so editing `~/.zshrc`, `~/.vimrc` or `~/.termux/*.properties` edits
the repository directly. Only the font and the package list need an explicit step:

```bash
cd ~/dotfiles-termux
cp ~/.termux/font.ttf .font.ttf          # if you changed the font
scripts/export-packages.sh               # regenerate packages.txt
git status                               # review, then commit on a feature branch
```

## ✅ Validation

Pull requests and pushes to `develop` or `main` run `bash -n`, shellcheck, a Python parse of
`bin/`, executable-bit and whitespace checks through GitHub Actions. Run the same checks locally
(`pkg install shellcheck` in Termux):

```bash
./tests/validate.sh
./tests/validate.sh --base-ref origin/develop   # also check the committed range
```

Releases follow the `vYYYY.MM.N` Calendar Versioning and Git Flow process documented in
[Gitflow Policy](docs/GITFLOW.md).

## 📚 Documentation

- [Package List & Categories](docs/PACKAGES.md)
- [Gitflow Policy](docs/GITFLOW.md)
- [Contributing](CONTRIBUTING.md) and [AI agent instructions](AGENTS.md)

## 🔗 Related repositories

The same owner keeps one dotfiles repository per platform. All of them follow the same gitflow,
Conventional Commits and `vYYYY.MM.N` release policy; `dotfiles-windows` is the reference.

- [dotfiles-windows](https://github.com/abrioso/dotfiles-windows) — Windows 11 (PowerShell, winget, WSL)
- [dotfiles-linux](https://github.com/abrioso/dotfiles-linux) — Ubuntu/Debian and RHEL/Fedora workstations and servers
