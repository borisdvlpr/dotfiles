#!/usr/bin/env zsh

# entry point: runs each setup step in order. safe to re-run
set -euo pipefail

cd "${0:A:h}"

[ "$(id -u)" -ne 0 ] || { echo "Do not run as root" >&2; exit 1; }
command -v curl >/dev/null || { echo "curl is required" >&2; exit 1; }
command -v git >/dev/null || { echo "git is required" >&2; exit 1; }

STEPS=(mise zed zsh-plugins)   # explicit allowlist, run in this order

for step in "${STEPS[@]}"; do
  echo "==> $step"
  zsh "setup/$step.sh" || { echo "FAILED: $step. Fix it and re-run." >&2; exit 1; }
done

if ! grep -qs 'mise activate' "$HOME/.zshrc"; then
  echo "note: ~/.zshrc does not activate mise, so its tools and JAVA_HOME are missing in new shells."
  echo "      Deploy config/zsh/.zshrc, or add: eval \"\$(\$HOME/.local/bin/mise activate zsh)\""
fi
