#!/usr/bin/env bash
# git rmi — remove a stale Git index.lock (including linked worktrees).
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: git rmi [options] [directory]

Remove Git's index.lock when it is stale (not held by a running process).
Resolves the correct lock file for linked worktrees.

Options:
  -f, --force     Remove index.lock even if a process appears to hold it
  -n, --dry-run   Show index and lock information without removing anything
  -v, --verbose   Show index and lock information before acting
  -h, --help      Show this help
EOF
}

force=false
dry_run=false
verbose=false
target="."

while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--force)
      force=true
      shift
      ;;
    -n|--dry-run)
      dry_run=true
      shift
      ;;
    -v|--verbose)
      verbose=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "git rmi: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      target="$1"
      shift
      break
      ;;
  esac
done

if [[ $# -gt 0 ]]; then
  echo "git rmi: unexpected argument: $1" >&2
  usage >&2
  exit 2
fi

if [[ ! -d "$target" ]]; then
  echo "git rmi: not a directory: $target" >&2
  exit 2
fi

git_dir="$(git -C "$target" rev-parse --absolute-git-dir 2>/dev/null)" || {
  echo "git rmi: not a git repository: $target" >&2
  exit 2
}

repo_root="$(git -C "$target" rev-parse --show-toplevel)"
common_dir="$(cd "$repo_root" && cd "$(git -C "$target" rev-parse --git-common-dir)" && pwd)"
index_file="$git_dir/index"
lock_file="$git_dir/index.lock"

describe_file() {
  local label="$1"
  local file="$2"

  if [[ ! -e "$file" ]]; then
    printf '%s: %s (missing)\n' "$label" "$file"
    return
  fi

  local size mtime
  if stat --version 2>/dev/null | grep -qi gnu; then
    size="$(stat -c '%s' "$file")"
    mtime="$(stat -c '%y' "$file")"
  else
    size="$(stat -f '%z' "$file")"
    mtime="$(stat -f '%Sm' -t '%Y-%m-%d %H:%M:%S %z' "$file")"
  fi
  printf '%s: %s (%s bytes, modified %s)\n' "$label" "$file" "$size" "$mtime"
}

lock_check_available() {
  command -v lsof >/dev/null 2>&1 || command -v fuser >/dev/null 2>&1
}

lock_in_use() {
  local file="$1"
  if command -v lsof >/dev/null 2>&1; then
    lsof "$file" >/dev/null 2>&1
    return
  fi
  if command -v fuser >/dev/null 2>&1; then
    fuser -s "$file" 2>/dev/null
    return
  fi
  return 1
}

lock_state() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "absent"
    return
  fi
  if ! lock_check_available; then
    echo "unknown"
    return
  fi
  if lock_in_use "$file"; then
    echo "in use"
  else
    echo "stale"
  fi
}

show_lock_holders() {
  local file="$1"
  if command -v lsof >/dev/null 2>&1; then
    lsof "$file" 2>/dev/null || true
  elif command -v fuser >/dev/null 2>&1; then
    fuser -v "$file" 2>/dev/null || true
  fi
}

print_index_info() {
  local worktree_kind="main worktree"
  if [[ "$git_dir" != "$common_dir" ]]; then
    worktree_kind="linked worktree"
  fi

  printf 'repository: %s\n' "$repo_root"
  printf 'git dir:    %s\n' "$git_dir"
  printf 'worktree:   %s\n' "$worktree_kind"
  describe_file "index" "$index_file"
  describe_file "index.lock" "$lock_file"

  local state
  state="$(lock_state "$lock_file")"
  printf 'lock state: %s\n' "$state"

  if [[ "$state" == "in use" ]]; then
    show_lock_holders "$lock_file"
  elif [[ "$state" == "unknown" ]]; then
    echo "lock check: unavailable (need lsof or fuser)"
  fi
}

if $verbose || $dry_run; then
  print_index_info
fi

if [[ ! -f "$lock_file" ]]; then
  if ! $verbose && ! $dry_run; then
    echo "No index.lock at $lock_file"
  fi
  exit 0
fi

if ! lock_check_available; then
  if ! $force; then
    echo "git rmi: cannot check lock status (need lsof or fuser); use -f to force" >&2
    exit 1
  fi
elif ! $force && lock_in_use "$lock_file"; then
  if ! $verbose && ! $dry_run; then
    echo "index.lock is in use: $lock_file" >&2
    show_lock_holders "$lock_file" >&2
  fi
  exit 1
fi

if $dry_run; then
  echo "Would remove $lock_file"
  exit 0
fi

rm -f "$lock_file"
echo "Removed $lock_file"
