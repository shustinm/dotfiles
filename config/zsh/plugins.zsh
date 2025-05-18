# Syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# Command completion based on histroy (press → or End to accept)
zinit ice wait="0a" lucid atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Command completions when pressing TAB
# zinit ice atload"zicompinit; zicdreplay" blockf atpull'zinit creinstall -q .'
# zinit light zsh-users/zsh-completions

# Auto close brackets/quotes like an IDE
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# Load fuzzy finding plugins (requires fzf)
if command -v fzf >/dev/null 2>&1; then
    zinit wait lucid for \
        joshskidmore/zsh-fzf-history-search \
        Aloxaf/fzf-tab
fi

# Oh-my-zsh snippet for ls aliases (ll, la...)
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git

# Replace builtins with superior utils
if [ "$DROP_IN_REPLACEMENTS" = "1" ]; then
    if command -v bat >/dev/null 2>&1; then
        alias cat="bat ${BAT_PARAMS}"
    fi
    if command -v eza >/dev/null 2>&1; then
        alias ls="eza ${EZA_PARAMS}"
    fi
fi

