#!/usr/bin/env bash

set -euo pipefail

repo="bloc97/Anime4K"
expr="Anime4K_v.*.zip"

install_mpv() {
  install_package mpv
  local shaders="$XDG_CONFIG_HOME/mpv/shaders"
  local tmpdir=$(dirname $(mktemp -u))
  if [[ -f "$shaders/version.txt" ]]; then
    local local_version=$(cat "$shaders/version.txt")
    fetch_from_git "$repo" "$expr" $tmpdir $local_version
  else
    mkdir $shaders
    fetch_from_git "$repo" "$expr" $tmpdir
  fi

  local output="$(compgen -G $tmpdir/Anime4K_*)"
  if [[ -f $output ]]; then
    msg info "extracting shaders"
    unzip -q "$output" -d "$shaders"
    rm $output
    # Log version to file.
    local ver=$(curl -Ls -o /dev/null -w %{url_effective} "https://github.com/bloc97/Anime4K/releases/latest")
    ver=${ver##*/}
    echo $ver >"$shaders/version.txt"
  fi

  whereis mpv
  mpv --version
}

install_mpv
