alias vz="$EDITOR $HOME/.zshrc"
alias vk="$EDITOR $HOME/.config/kitty/kitty.conf"
alias v=$EDITOR

alias kvim="NVIM_APPNAME= kv -p nvim010"
alias lvim="NVIM_APPNAME=lazyvim nvim"
alias lv="lvim"

export NVIM_APPNAME="lazyvim"

alias grep='grep --color=auto'

function vf {
    filename=$(fzf)
    if [ -n "${filename}" ]; then
        $EDITOR ${filename}
    fi
}

unalias gco
function gco {
    if [ $# -eq 0 ]; then
        git checkout -q $(git branch --sort=-committerdate | fzf)
    else
        git checkout "$@"
    fi
}

function gph {
    git pull origin $(git rev-parse --abbrev-ref HEAD)
}

# Uses banyan/zsh-fzf-git-worktree
alias gwt=fzf-git-worktree

# Function to list interfaces with IPv4 addresses
ip4_interfaces() {
  ifconfig | awk '/^[a-z]/ {iface=$1} /inet / {print iface, $2}'
}

# Function to list interfaces with IPv6 addresses
ip6_interfaces() {
  ifconfig | awk '/^[a-z]/ {iface=$1} /inet6 / {print iface, $2}'
}

# ifconfig aliases
alias ip4="ip4_interfaces"
alias ip6="ip6_interfaces"

# neofetch alias for fastfetch
if command -v fastfetch >/dev/null 2>&1; then
    alias neofetch="fastfetch"
fi

# icloud alias (macOS only)
if [[ "$OSTYPE" == darwin* ]]; then
    alias icloud="cd '$HOME/Library/Mobile Documents/com~apple~CloudDocs/'"
fi

if command -v lstr >/dev/null 2>&1; then
    alias lstr="lstr --icons"
    alias lll="lstr -L2"
fi
