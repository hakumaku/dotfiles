#!/usr/bin/env bash

set -euo pipefail

repo="derailed/k9s"
expr="k9s_Linux_amd64.tar.gz"

fetch_from_git_k9s() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v k9s &>/dev/null; then
    local local_version=$(k9s version | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | sed -rn 's/^Version:\s*(.*)/\1/p')
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  local output="$(compgen -G $tmpdir/k9s_*)"
  if [[ -f $output ]]; then
    msg info "extracting binary"
    tar -xzf $output --directory "$HOME/.local/bin"
    rm $output
    rm "$HOME/.local/bin/LICENSE" "$HOME/.local/bin/README.md"
  fi

  whereis k9s
  k9s version
}

fetch_from_git_k9s
