setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt auto_cd
export HISTSIZE=100000
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=$HISTSIZE
WORDCHARS=${WORDCHARS//\//}

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Initialize Starship prompt
eval "$(starship init zsh)"

# Completions should be case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Aliases and fixes for kitty terminal
if [ "$TERM" = "xterm-kitty" ]; then
    alias kt="kitty +kitten"
    alias icat="kitty +kitten icat"

    # kitty ssh fix: https://wiki.archlinux.org/title/Kitty#Terminal_issues_with_SSH
    alias ssh="kitty +kitten ssh"
fi

if [ -f $XDG_CONFIG_HOME/op/plugins.sh ]; then
    source $XDG_CONFIG_HOME/op/plugins.sh
fi

for file in vars.zsh plugins.zsh aliases.zsh keybinds.zsh; do
    [ -f "$XDG_CONFIG_HOME/zsh/$file" ] && source "$XDG_CONFIG_HOME/zsh/$file"
done

# VAST
if [ -d $HOME/Developer/vast ]; then
    source $HOME/Developer/vast/initrc.sh
fi

# WIP
function _git_checkout_limited_branches() {
  # If not in a Git repo, fall back to default
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    _call_function ret _git-checkout
    return
  fi

  # Otherwise, list just the most recent branches
  local branches=("${(@f)$(git for-each-ref \
    --sort=-committerdate --format='%(refname:short)' refs/heads/ | head -n 8)}")
  _describe -V -t branches 'branches' branches
}
compdef _git_checkout_limited_branches git=checkout
