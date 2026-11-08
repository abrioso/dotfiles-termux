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

pkg list-installed 2>/dev/null \
    | grep -v automatic \
    | grep installed \
    | awk -F/ '{print $1}' \
    | sort -u > "$PKG_FILE"

printf '[ OK ] Wrote %s packages to %s\n' "$(wc -l < "$PKG_FILE")" "$PKG_FILE"
