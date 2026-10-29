# dotfiles

My Mac setup: WezTerm, zsh + Oh My Zsh, herdr, git, and one shared `AGENTS.md` for AI tools.

## New Mac

```bash
git clone https://github.com/matheusmorcinek/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

The script installs Homebrew, the apps in `Brewfile`, and Oh My Zsh, then symlinks
each config to where its program looks for it. Existing files are kept as `*.backup`.

## Day to day

- Edit configs in place (`~/.zshrc`, `~/.wezterm.lua`, ...) — they are symlinks into this repo.
- Save: `git add . && git commit -m "..." && git push`
- Other Mac: `git pull` — changes are live immediately.
- New config or tool: add a `link` line to `install.sh` (and the app to `Brewfile`), re-run it.

## AGENTS.md

One file, linked to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`.
