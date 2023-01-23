#!/usr/bin/env bash

set -euo pipefail

repo="bitnami-labs/sealed-secrets"
expr="kubeseal-.*-linux-amd64.tar.gz$"

fetch_from_git_lazydocker() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v kubeseal &>/dev/null; then
    local local_version=$(kubeseal --version | sed -rn 's/^kubeseal version: ([^,]*).*/\1/p')
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  local output="$(compgen -G $tmpdir/kubeseal*)"
  if [[ -f $output ]]; then
    msg info "extracting binary"
    tar -xzf $output --directory "$HOME/.local/bin"
    rm $output
    rm "$HOME/.local/bin/LICENSE" "$HOME/.local/bin/README.md"
  fi

  whereis kubeseal
  kubeseal --version
}

fetch_from_git_lazydocker


