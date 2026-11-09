#!/usr/bin/env zsh

# step: install Zed, link its settings
set -euo pipefail
source "${0:A:h}/lib.sh"

if [ -x "$HOME/.local/bin/zed" ]; then
  echo "ok      zed already installed"
else
  curl -fsSL https://zed.dev/install.sh | sh
fi

link config/zed/settings.json "$HOME/.config/zed/settings.json"
