#!/usr/bin/env bash

set -euo pipefail

clone_or_pull_zsh_plugins() {
  local repos=(
    "romkatv/powerlevel10k.git"
    "zsh-users/zsh-syntax-highlighting.git"
    "jeffreytse/zsh-vi-mode.git"
    "zsh-users/zsh-autosuggestions.git"
  )

  for repo in ${repos[@]}; do
    clone_or_pull "$repo"
    clone_or_pull_done
  done
}

install_zsh() {
  if ! command -v zsh &>/dev/null; then
    msg info "installing zsh"
    install_package zsh
    chsh -s $(which zsh)

    msg info "configuring ZDOTDIR"
    echo 'ZDOTDIR=$HOME/.config/zsh' | sudo tee -a /etc/zsh/zshenv
  fi

  clone_or_pull_zsh_plugins
}

install_zsh
