#!/usr/bin/env bash
# export-packages.sh — Regenerate packages.txt from the packages installed in Termux
# Usage: scripts/export-packages.sh
#
# Writes the explicitly installed (non-automatic) packages, one per line and
# sorted, to packages.txt in the repository root. Review the diff before committing.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
PKG_FILE="$REPO_DIR/packages.txt"

case "${1:-}" in
    --help|-h)
        sed -n '2,6p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
        exit 0
        ;;
esac

if ! command -v pkg >/dev/null 2>&1; then
    echo "This script must run inside Termux (pkg not found)." >&2
    exit 1
fi

# Build the list in a temporary file so a failing pipeline never truncates packages.txt
TMP_FILE="$(mktemp "$REPO_DIR/.packages.txt.XXXXXX")"
trap 'rm -f "$TMP_FILE"' EXIT

pkg list-installed 2>/dev/null \
    | grep -v automatic \
    | grep installed \
    | awk -F/ '{print $1}' \
    | sort -u > "$TMP_FILE"

if [ ! -s "$TMP_FILE" ]; then
    echo "No installed packages found; packages.txt left unchanged." >&2
    exit 1
fi

mv "$TMP_FILE" "$PKG_FILE"
printf '[ OK ] Wrote %s packages to %s\n' "$(wc -l < "$PKG_FILE")" "$PKG_FILE"
