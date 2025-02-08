If you're reading this, it's likely that you've been referred because you're new to shell configuration, don't have your shell configured, or worse, use oh-my-zsh.

To be cool like me, run the installation script below.
> [!IMPORTANT]  
> This is an installer for a _personal_ configuration of mine. This means that there are things irrelevant for your setup, and some opinionated (but configurable) defaults. The sections below will guide you through the configuration and things you might want to customize.

## Installation script
```bash
curl -fsSL https://raw.githubusercontent.com/shustinm/dotfiles/main/config/zsh/install.sh | bash
```

## Explanations
After running the script, create a new terminal window (if you elected to install ghostty - open it), the shell plugins should take a short while to install.

The entrypoint of the zsh configuration is the `.zshrc` file, located in your home directory. Let's take a look at it:

```bash
cat ~/.zshrc
```

If you ever used `cat`, you'll notice it's suddenly much better. You have syntax highlighting and can scroll inside the file (press q to quit). Here's what you need to know - thisn't `cat`, this is `bat`. My terminal configuration replaces some programs with a more modern alternatives. You'll see later how you can change this behavior.

### ~/.zshrc
The `.zshrc` file is the entrypoint of the zsh configuration, (it runs every time zsh starts). It's a bit long and frightening, in general - it sets up some some zsh params, makes sure zinit (zsh plugin manager) is installed, as well as starship (shell prompt), and completions. The next important part is nearly at the bottom. It sources (runs) the other configuration files. They are located in `$HOME/.config/zsh`

### ~/.config/zsh/vars.zsh
This is a variable/configuration file. 
You should change the value of the EDITOR env var, as you're likely not using `nvim` (so change it to `vim`). The `DROP_IN_REPLACEMENTS` variable enables replacing cat with bat, so you can disable if you don't like it. But here's another trick: 
```console
❯ cat file.txt  # Will use bat
❯ \cat file.txt  # Will ignore aliases, and won't use bat
```

### ~/.config/zsh/plugins.zsh
This file installs all the plugins with `zinit`, so it's difficult to read if you're not familiar with it. Go over the file and read the comments - they mostly explain what the plugin does.

### ~/.config/zsh/aliases.zsh
This file contains aliases that I'm using. For example, A very nice but simple alias is `gco`. Usually `gco` is an alias for `git checkout`, But if you run `gco` without any parameters, it will show you all the branches (sorted by last commit date) and you can choose which branch you want to check out. This "advanced" usage is possible because `gco` is actually a function, but it's implementation is super simple (leverages fzf)

### Other files
Also the `~/.zshenv` and `~/.zprofile` files are relevant, so take a quick look at them. They mostly set up env variables like `PATH`.
