
# Use drop-in replacements when installed, for example eza instead of ls, and bat instead of cat
# You can always avoid the aliased command by running "\cat" instead of "cat", etc.
export DROP_IN_REPLACEMENTS=1

# Eza params
export EZA_PARAMS="--octal-permissions --no-permissions --icons --header"

# Use nvim as editor, but disable vim mode in terminal
export EDITOR=nvim
bindkey -e
