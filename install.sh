#!/usr/bin/env bash
# Sets up this Mac from the dotfiles repo. Safe to re-run.
set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# ─── 1. Homebrew + apps ──────────────────────────────────────────────
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew bundle --no-upgrade --file="$DOTFILES/Brewfile"

# ─── 2. Oh My Zsh ────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ─── 3. Symlinks ─────────────────────────────────────────────────────
# link <file in repo> <where the program looks for it>
link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.backup"               # keep the original, just in case
    echo "backed up $dst → $dst.backup"
  fi
  ln -sfn "$src" "$dst"
  echo "linked $dst → $src"
}

link .zshrc                   "$HOME/.zshrc"
link .wezterm.lua             "$HOME/.wezterm.lua"
link .gitconfig               "$HOME/.gitconfig"
link .config/git/ignore       "$HOME/.config/git/ignore"
link .config/herdr/config.toml "$HOME/.config/herdr/config.toml"
link .config/keys/keys.txt    "$HOME/.config/keys/keys.txt"
link .config/keys/herdr.txt   "$HOME/.config/keys/herdr.txt"

# AI tools: one AGENTS.md, read by all of them
link AGENTS.md                "$HOME/.claude/CLAUDE.md"
link AGENTS.md                "$HOME/.codex/AGENTS.md"
