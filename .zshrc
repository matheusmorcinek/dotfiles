# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# ─── PATH ────────────────────────────────────────────────────────────
typeset -U path PATH                      # drop duplicate entries automatically
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $HOME/.local/bin                        # claude, kiro-cli, Antigravity
  $path
)
export PATH

# ─── oh-my-zsh ───────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git nvm)                         # nvm plugin loads ~/.nvm/nvm.sh
source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# ─── Aliases ─────────────────────────────────────────────────────────
alias cc='claude'                         # shadows /usr/bin/cc in interactive shells only
alias zshconfig='${EDITOR:-nano} ~/.zshrc'
alias ewez='${EDITOR:-nano} ~/.wezterm.lua'
alias dot='code ~/dotfiles'               # open dotfiles repo in VS Code
alias aliases='sed -n "s/^alias //p" ~/.zshrc'   # list my custom aliases
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias add='git add .'
alias push='git push'
alias pull='git pull'
alias m='git switch main'

# Cheat sheets in ~/.config/keys/ (<cmd> / <cmd> <word> / <cmd> -e)
keys()  { _cheatsheet ~/.config/keys/keys.txt "$@" }    # general shortcuts
keysh() { _cheatsheet ~/.config/keys/herdr.txt "$@" }   # herdr only
_cheatsheet() {
  local f=$1; shift
  if [[ $1 == -e ]]; then ${EDITOR:-nano} $f; return; fi
  awk -v q="${(L)*}" '
    /^#/ || /^$/ { next }
    /^\[/ { sec = $0; shown = 0; next }
    q == "" || index(tolower(sec " " $0), q) {
      if (!shown) { printf "%s\033[1;36m%s\033[0m\n", (n++ ? "\n" : ""), sec; shown = 1 }
      print "  " $0
    }' $f
}

# ─── Plugins (brew) ──────────────────────────────────────────────────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh   # ghost text from history
bindkey '^f' autosuggest-accept                                         # Ctrl+F accepts the suggestion
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # must stay last of the plugins

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
