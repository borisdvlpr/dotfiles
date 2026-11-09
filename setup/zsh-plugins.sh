#!/usr/bin/env zsh

# step: clone or update zsh plugins in ~/.zsh/plugins
set -euo pipefail

PLUGINS_DIR="$HOME/.zsh/plugins"
PLUGINS=(zsh-users/zsh-autosuggestions)   # GitHub owner/repo

mkdir -p "$PLUGINS_DIR"

for repo in "${PLUGINS[@]}"; do
  dir="$PLUGINS_DIR/${repo:t}"

  if [ -d "$dir/.git" ]; then
    git -C "$dir" pull --ff-only --quiet
    echo "updated $dir"
    continue
  fi

  # not a git clone (e.g. an unzipped download): keep it as a backup
  if [ -e "$dir" ]; then
    bak="$dir.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dir" "$bak"
    echo "backup  $dir -> $bak"
  fi

  git clone --quiet "https://github.com/$repo.git" "$dir"
  echo "cloned  $dir"
done
