# import_config

Import a directory from `~/.config` into this dotfiles repo so it's tracked in git.

## Input

`$ARGUMENTS` — optional name of a directory in `~/.config` to import.

## Steps

1. **If no argument is provided**, list all directories in `~/.config` that are **not** symlinks, sorted by modification date (most recent first). Use `find ~/.config -maxdepth 1 -mindepth 1 -type d ! -type l` piped through `stat` to sort by modification time. Show the list to the user and ask which one to import. Do not proceed without an answer.

2. **Validate** the chosen name:
   - `~/.config/<name>` must exist and be a real directory (not a symlink — symlinks mean it's already imported).
   - `config/<name>` must not already exist in this repo.

3. **Copy** `~/.config/<name>` into `config/<name>` in this repo (use `cp -a` to preserve attributes).

4. **Delete** the original `~/.config/<name>` directory so the symlink can be created in its place.

5. **Run** `./install --only link` from the repo root to have dotbot create all symlinks.

6. **Verify** that `~/.config/<name>` is now a symlink pointing into this repo. Print the result of `readlink ~/.config/<name>` and confirm it resolves to the repo's `config/<name>`.
