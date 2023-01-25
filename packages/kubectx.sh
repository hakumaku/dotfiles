#!/usr/bin/env bash

set -euo pipefail

repo="ahmetb/kubectx"
expr="kubectx_v.*_linux_x86_64.tar.gz"

fetch_from_git_kubectx() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v kubectx &>/dev/null; then
    local local_version=$(kubectx --version | sed -rn 's/^([^,]*).*/\1/p')
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  local output="$(compgen -G $tmpdir/kubectx*)"
  if [[ -f $output ]]; then
    msg info "extracting binary"
    tar -xzf $output --directory "$HOME/.local/bin"
    rm $output
    rm "$HOME/.local/bin/LICENSE" "$HOME/.local/bin/README.md"
  fi

  whereis kubectx
  kubectx --version
}

fetch_from_git_kubectx

