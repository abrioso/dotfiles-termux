# Packages

This repository uses `packages.txt` in the root directory to track installed Termux packages.

## How packages are managed

- `packages.txt` contains one package name per line (alphabetically sorted)
- `bootstrap.sh` reads this file and installs all listed packages via `pkg install`
- Comment lines (`#`) and blank lines are ignored by `bootstrap.sh`
- To add a package: install it, then run `scripts/export-packages.sh` or add it manually

## Package categories

### Core utilities
coreutils, findutils, grep, sed, gawk, diffutils, patch, less, lsof, procps, psmisc

### Development
git, gh, python, python-pip, nodejs, npm, vim, make, clang, cmake, rust

### Networking
curl, wget, openssh, dnsutils, net-tools, inetutils, traceroute, whois

### Media
ffmpeg, imagemagick, graphviz

### File management
p7zip, unrar, unzip, tar, gzip, bzip2, xz-utils, zstd, rclone

### Terminal
zsh, tmux, htop, ripgrep

## Updating the package list

```bash
scripts/export-packages.sh
```

The script keeps only explicitly installed packages (dependencies marked `automatic` are
excluded), sorts them and overwrites `packages.txt`. Review the diff before committing.
