#!/usr/bin/env bash
# install.sh — Symlink dotfiles into $HOME and ~/.termux
# Usage: bash install.sh [--dry-run] [--force]
#   --dry-run  Show what would be done without making changes
#   --force    Never prompt; Git identity comes from GIT_USER_NAME/GIT_USER_EMAIL
#              or the existing git config, otherwise it is left unset
#
# Existing regular files that would be replaced are moved to ~/.dotfiles-backup/<timestamp>.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERMUX_DIR="$HOME/.termux"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
FORCE=false

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=true ;;
        --force) FORCE=true ;;
        --help|-h)
            sed -n '2,8p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
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

backup_file() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local rel_path="${file#"$HOME"/}"
        local backup_path="$BACKUP_DIR/$rel_path"
        if [ "$DRY_RUN" = true ]; then
            info "[DRY-RUN] Would backup: $file -> $backup_path"
        else
            mkdir -p "$(dirname "$backup_path")"
            mv "$file" "$backup_path"
            info "Backed up: $file -> $backup_path"
        fi
    fi
}

# link <source-in-repo> <target-in-home>
link() {
    local source="$1" target="$2"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        info "Already linked: $target"
        return 0
    fi
    backup_file "$target"
    if [ "$DRY_RUN" = true ]; then
        info "[DRY-RUN] Would link: $target -> $source"
    else
        mkdir -p "$(dirname "$target")"
        ln -sfn "$source" "$target"
        success "Linked: $target -> $source"
    fi
}

# Create or complete ~/.gitconfig.local (untracked) with the Git identity.
# Sources, in order: values already in the local file, GIT_USER_NAME /
# GIT_USER_EMAIL, the identity Git currently resolves (for example a
# pre-existing ~/.gitconfig that is about to be replaced), then an interactive
# prompt. With --force nothing is asked and a missing identity is only
# reported; no placeholder identity is ever written.
setup_git_config() {
    local local_config="$HOME/.gitconfig.local"
    if ! command -v git >/dev/null 2>&1; then
        warn "git not found; skipping Git identity setup."
        return 0
    fi
    local git_name git_email
    git_name=$(git config --file "$local_config" --get user.name 2>/dev/null || true)
    git_email=$(git config --file "$local_config" --get user.email 2>/dev/null || true)
    if [ -n "$git_name" ] && [ -n "$git_email" ]; then
        info "Git identity already configured in $local_config"
        return 0
    fi
    if [ -z "$git_name" ]; then
        git_name="${GIT_USER_NAME:-$(git config --global --get user.name 2>/dev/null || true)}"
    fi
    if [ -z "$git_email" ]; then
        git_email="${GIT_USER_EMAIL:-$(git config --global --get user.email 2>/dev/null || true)}"
    fi
    if [ "$FORCE" = false ] && [ "$DRY_RUN" = false ]; then
        if [ -z "$git_name" ]; then
            read -rp "Git user name: " git_name
        fi
        if [ -z "$git_email" ]; then
            read -rp "Git email: " git_email
        fi
    fi
    if [ -z "$git_name" ] || [ -z "$git_email" ]; then
        warn "Git identity not configured. Export GIT_USER_NAME and GIT_USER_EMAIL, run install.sh without --force, or edit $local_config."
        return 0
    fi
    if [ "$DRY_RUN" = true ]; then
        info "[DRY-RUN] Would set user.name/user.email in $local_config"
        return 0
    fi
    if [ ! -f "$local_config" ]; then
        cat > "$local_config" <<EOF_LOCAL
# ~/.gitconfig.local — machine-specific Git settings (not tracked by dotfiles-termux)
# Uncomment to enforce the gitflow hooks on every repository of this device:
#[core]
#    hooksPath = $SCRIPT_DIR/git-hooks
EOF_LOCAL
    fi
    git config --file "$local_config" user.name "$git_name"
    git config --file "$local_config" user.email "$git_email"
    success "Configured Git identity in $local_config"
}

# Git identity first, so an existing ~/.gitconfig can be read before it is replaced
setup_git_config

# Shell, editor and Git
link "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
link "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
link "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"

# Termux settings
link "$SCRIPT_DIR/.termux.properties" "$TERMUX_DIR/termux.properties"
link "$SCRIPT_DIR/.colors.properties" "$TERMUX_DIR/colors.properties"

# Font: Termux reads the file directly, so copy it instead of linking
if [ -f "$SCRIPT_DIR/.font.ttf" ]; then
    if [ -f "$TERMUX_DIR/font.ttf" ] && [ ! -L "$TERMUX_DIR/font.ttf" ] \
        && cmp -s "$SCRIPT_DIR/.font.ttf" "$TERMUX_DIR/font.ttf"; then
        info "Font already up to date."
    else
        backup_file "$TERMUX_DIR/font.ttf"
        if [ "$DRY_RUN" = true ]; then
            info "[DRY-RUN] Would copy font to $TERMUX_DIR/font.ttf"
        else
            mkdir -p "$TERMUX_DIR"
            # A symlinked font.ttf is replaced by the link itself, never by
            # writing through it into the link target.
            [ -L "$TERMUX_DIR/font.ttf" ] && rm -f "$TERMUX_DIR/font.ttf"
            cp "$SCRIPT_DIR/.font.ttf" "$TERMUX_DIR/font.ttf"
            success "Installed font: $TERMUX_DIR/font.ttf"
        fi
    fi
fi

# Custom scripts (added to PATH by .zshrc)
if [ -d "$SCRIPT_DIR/bin" ]; then
    for script in "$SCRIPT_DIR"/bin/*; do
        [ -f "$script" ] || continue
        link "$script" "$HOME/bin/$(basename "$script")"
    done
fi

# Default shell
if command -v zsh >/dev/null 2>&1; then
    if [ "$DRY_RUN" = true ]; then
        info "[DRY-RUN] Would set zsh as the default shell"
    elif [ "${SHELL:-}" != "$(command -v zsh)" ]; then
        if chsh -s zsh; then
            success "Default shell set to zsh (restart Termux to apply)."
        else
            warn "Could not change the default shell. Run: chsh -s zsh"
        fi
    else
        info "Default shell is already zsh."
    fi
else
    warn "zsh is not installed; run bootstrap.sh first."
fi

# Reload Termux settings
if [ "$DRY_RUN" = false ] && command -v termux-reload-settings >/dev/null 2>&1; then
    termux-reload-settings || true
fi

if [ -d "$BACKUP_DIR" ]; then
    info "Backups saved to: $BACKUP_DIR"
fi
success "Dotfiles installation complete!"
