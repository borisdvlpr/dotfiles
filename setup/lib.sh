# Shared helpers for setup steps. Source this file; do not run it.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

# link <path in repo> <target>
# Symlinks target to the repo file. A correct link is left alone; anything
# else already at target is moved to <target>.bak.<timestamp>, never deleted.
link() {
  local src="$DOTFILES/$1" dst="$2"

  if [ ! -e "$src" ]; then
    echo "missing $src" >&2
    return 1
  fi

  if [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok      $dst"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    local bak
    bak="$dst.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$bak"
    echo "backup  $dst -> $bak"
  fi

  ln -s "$src" "$dst"
  echo "linked  $dst -> $src"
}
