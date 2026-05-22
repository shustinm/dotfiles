#!/usr/bin/env bash
# Alphabetize package manifest files.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

sort_lines() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  LC_ALL=C sort -u -o "$file" "$file"
  sed -i '' -e '/^[[:space:]]*$/d' "$file" 2>/dev/null || sed -i -e '/^[[:space:]]*$/d' "$file"
}

sort_brewfile() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  local tmp
  tmp="$(mktemp)"
  {
    { grep '^tap ' "$file" || true; } | LC_ALL=C sort -u
    { grep '^brew ' "$file" || true; } | LC_ALL=C sort -u
    { grep '^cask ' "$file" || true; } | LC_ALL=C sort -u
    { grep -v -e '^tap ' -e '^brew ' -e '^cask ' "$file" || true; } | LC_ALL=C sort -u
  } >"$tmp"
  mv "$tmp" "$file"
}

sort_one() {
  local rel="$1"
  local file="$root/$rel"
  case "$rel" in
    Brewfile) sort_brewfile "$file" ;;
    *) sort_lines "$file" ;;
  esac
}

default_manifests=(
  apt/packages.txt
  dnf/repos.txt
  dnf/packages.txt
  Brewfile
)

if [[ $# -gt 0 ]]; then
  targets=("$@")
else
  targets=("${default_manifests[@]}")
fi

for rel in "${targets[@]}"; do
  sort_one "$rel"
done
