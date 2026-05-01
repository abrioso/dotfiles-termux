# Contributing

## Branching Strategy

This project uses **gitflow**:

| Branch | Purpose | Merges into |
|--------|---------|-------------|
| main | Stable releases | — |
| develop | Next release integration | main (via release PR) |
| feature/* | New functionality | develop |
| fix/* | Non-critical fixes | develop |
| hotfix/* | Critical fixes | main + develop |
| release/* | Release prep | main |

## How to Contribute

1. **Fork** or create a feature branch from `develop`:
   ```bash
   git checkout develop && git pull
   git checkout -b feature/my-change
   ```

2. **Make your changes** following the code standards below.

3. **Commit** using [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat:` — new feature
   - `fix:` — bug fix
   - `docs:` — documentation only
   - `chore:` — maintenance, deps
   - `refactor:` — code restructure without behavior change

4. **Push and open a PR** targeting `develop`:
   ```bash
   git push -u origin feature/my-change
   gh pr create --base develop
   ```

5. **Wait for review** before merging.

## Code Standards

### Scripts
- Use `#!/bin/bash` with `set -euo pipefail` for new scripts. Existing scripts will be migrated incrementally.
- Must pass `shellcheck` cleanly
- Must be idempotent (safe to re-run)
- Use functions for logical grouping
- Add `--help` flag for user-facing scripts

### Documentation
- Update `README.md` when adding features
- Document new packages in `docs/PACKAGES.md` and keep `packages.txt` updated
- Keep lists sorted alphabetically

### Dotfiles
- Dotfiles live in the repository root (e.g., `.zshrc`, `.vimrc`)
- `install.sh` creates symlinks from the repo to `$HOME`
- Custom scripts go in `bin/`

## Release Process

1. Create `release/vX.Y.Z` from `develop`
2. Bump version references, update CHANGELOG
3. PR into `main`, tag after merge
4. Merge `main` back into `develop`
