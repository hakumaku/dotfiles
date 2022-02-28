#!/usr/bin/env bash

set -euo pipefail

repo="mvdan/sh"
expr="shfmt_v.*_linux_amd64"

fetch_from_git_shfmt() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v shfmt &>/dev/null; then
    local local_version=$(shfmt --version)
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  local output="$(compgen -G $tmpdir/shfmt_*)"
  if [[ -f $output ]]; then
    local dir="$HOME/.local/bin"
    msg info "copying binary file to $dir"
    mv $output $dir/shfmt
    chmod +x $dir/shfmt
  fi

  whereis shfmt
  shfmt --version
}

fetch_from_git_shfmt
