#!/usr/bin/env bash
# Step: install mise, link the global config, install its tools.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

MISE="$HOME/.local/bin/mise"

if [ -x "$MISE" ]; then
  echo "ok      mise already installed"
else
  curl -fsSL https://mise.run | sh
fi

link config/mise/global.toml "$HOME/.config/mise/config.toml"

# Run from $HOME so no project config in the current directory applies.
cd "$HOME"
"$MISE" install --yes
