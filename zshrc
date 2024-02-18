
alias lss='/bin/ls'
alias ls="exa"
alias ll="ls --octal-permissions --no-permissions --icons -h -l"

alias cat="bat"
alias ccat=/bin/cat

alias lv=lvim
export EDITOR=nvim

alias vz="$EDITOR $HOME/.zshrc"
alias v=$EDITOR

alias ctop='docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'

alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'

function vf {
    filename=$(fzf)
    if [ -n "${filename}" ]; then
        $EDITOR ${filename}
    fi
}

alias gst="git status"
alias gp="git push"
alias gc="git commit"
alias ga="git add"
alias gu="git add -u"
alias gco="git checkout"
alias gfo="git fetch origin"
alias gs="git switch"

function gph {
    git pull origin $(git rev-parse --abbrev-ref HEAD)
}

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

eval "$(starship init zsh)"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# junegunn/fzf-bin
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
export BAT_THEME="ansi"

# ogham/exa, replacement for ls
zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa
export PATH="$HOME/.local/share/zinit/plugins/ogham---exa/bin:$PATH"

# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

zinit ice from"gh-r" as"program" mv"docker* -> docker-compose"
zinit light docker/compose

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

autoload compinit
compinit -u

zinit wait lucid light-mode for \
  atinit"zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
     zsh-users/zsh-completions

zinit light Aloxaf/fzf-tab

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


if [[ $OSTYPE == 'darwin'* ]]; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby@2.7/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


# VAST DATA
export PATH="$PATH:$HOME/Developer/infra/user-scripts"

alias klog='kubectl logs -n aqua'

# export GOPATH=$HOME/go/pkg/mod
export GO111MODULE=on
export GOPRIVATE=bitbucket.org/scalock/

# kitty ssh fix: https://wiki.archlinux.org/title/Kitty#Terminal_issues_with_SSH
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
alias sshh="/usr/bin/ssh"

alias kt="kitty +kitten"
alias icat="kt icat"

source $HOME/.config/op/plugins.sh
