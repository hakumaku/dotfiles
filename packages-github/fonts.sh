#!/usr/bin/env bash

set -euo pipefail

fetch_from_git_fonts() {
  # TODO: version check?
  local dir="$HOME/.local/share/fonts"
  if [[ ! -d $dir ]]; then
    msg info "mkdir -p $dir"
    mkdir -p $dir
  fi

  msg info "installing fonts"
  install_package fonts

  local fonts=(
    "Ubuntu.zip"
    "SourceCodePro.zip"
    "Meslo.zip"
  )
  for font in ${fonts[@]}; do
    fetch_from_git "ryanoasis/nerd-fonts" $font $dir
  done

  msg info "extracting fonts"
  for font in ${fonts[@]}; do
    unzip -qq -d "$dir/${font%.zip}" "$dir/$font"
    rm "$dir/$font"
  done
  msg info "fc-cache -fv"
  fc-cache -fv >/dev/null
}

fetch_from_git_fonts
