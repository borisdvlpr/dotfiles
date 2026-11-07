#!/usr/bin/env bash
# Step: install Zed, link its settings.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if [ -x "$HOME/.local/bin/zed" ]; then
  echo "ok      zed already installed"
else
  curl -fsSL https://zed.dev/install.sh | sh
fi

link zed/settings.json "$HOME/.config/zed/settings.json"
