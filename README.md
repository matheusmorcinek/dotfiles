# dotfiles

My Mac setup: WezTerm, zsh + Oh My Zsh, Neovim (LazyVim), herdr, git, and one shared `AGENTS.md` for AI tools.

## New Mac

```bash
git clone https://github.com/matheusmorcinek/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

The script installs Homebrew, the apps in `Brewfile`, and Oh My Zsh, then symlinks
each config to where its program looks for it. Existing files are kept as `*.backup`.
It then asks for your git name and email and saves them to `~/.gitconfig.local`, which
is not part of this repo, so each Mac can commit as a different person.

Not installed by the script: Claude Code, VS Code, a Node version (`nvm install --lts`),
and your GitHub login (`gh auth login`).

## How it works

```
GitHub (matheusmorcinek/dotfiles)
        ▲  git push / git pull (you trigger it)
        │
~/dotfiles/   ← the real files live here
        ▲
        │  symlinks (created once by install.sh)
        │
~/.zshrc, ~/.wezterm.lua, ~/.gitconfig, ~/.config/herdr/config.toml, ~/.config/nvim,
~/.claude/CLAUDE.md, ~/.codex/AGENTS.md   ← where programs look
```

`~/.zshrc` is not a copy — it points at `~/dotfiles/.zshrc`. Editing either path edits
the same file, so changes show up in this repo instantly. Nothing runs in the background.

## Workflows

`dot` opens this repo in VS Code.

### Change a config (on any Mac)

1. Edit it — `zshconfig`, `ewez`, `dot`, or any editor. The repo already has the change.
2. Apply it:
   - zsh: `reload` (or open a new tab)
   - WezTerm: reloads itself on save
   - herdr, git, AI tools: picked up next time they start
3. Save it to GitHub:
   ```bash
   cd ~/dotfiles
   git status                # what changed
   git add . && git commit -m "describe the change" && git push
   ```

### Get the change on the other Mac

```bash
cd ~/dotfiles && git pull
```

That's it — the links already point here. Run `reload` in open zsh tabs.

### Add a new config file or app

1. Copy the file into the repo at the same path it has under `~` (e.g. `~/.config/foo/x.toml` → `~/dotfiles/.config/foo/x.toml`).
2. Add `link .config/foo/x.toml "$HOME/.config/foo/x.toml"` to `install.sh`; add the app to `Brewfile` if needed.
3. Run `~/dotfiles/install.sh` — the original is kept as `*.backup`.
4. Commit and push. On the other Mac: `git pull && ~/dotfiles/install.sh`.

## AGENTS.md

One file, linked to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`.
