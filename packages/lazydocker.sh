#!/usr/bin/env bash

set -euo pipefail

repo="jesseduffield/lazydocker"
expr="lazydocker_.*_Linux_x86_64.tar.gz"

fetch_from_git_lazydocker() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v lazydocker &>/dev/null; then
    local local_version=$(lazydocker --version | sed -rn 's/^Version: ([^,]*).*/\1/p')
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  local output="$(compgen -G $tmpdir/lazydocker_*)"
  if [[ -f $output ]]; then
    msg info "extracting binary"
    tar -xzf $output --directory "$HOME/.local/bin"
    rm $output
    rm "$HOME/.local/bin/LICENSE" "$HOME/.local/bin/README.md"
  fi

  whereis lazydocker
  lazydocker --version
}

fetch_from_git_lazydocker

