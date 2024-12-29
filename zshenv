export XDG_CONFIG_HOME="$HOME/.config"

# Priority before standard PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"

# Priority before standard PATH
export PATH="$PATH:$HOME/go/bin"

# Source cargo (rust) if exists
if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi

if command -v nvim >/dev/null 2>&1; then
	export EDITOR=nvim
fi

