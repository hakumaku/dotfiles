#!/usr/bin/env bash

clone_or_pull_numix() {
  msg info "installing numix-icon"
  clone_or_pull_aur numix-icon-theme-git.git
  makepkg -si
  clone_or_pull_done

  msg info "installing numix-circle-icon"
  clone_or_pull_aur numix-circle-icon-theme-git.git
  makepkg -si
  clone_or_pull_done
}

clone_or_pull_numix
