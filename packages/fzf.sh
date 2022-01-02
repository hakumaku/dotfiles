#!/usr/bin/env bash

clone_or_pull_fzf() {
  clone_or_pull "junegunn/fzf.git"
  msg info "./fzf/install --xdg"
  $PWD/install --xdg
  clone_or_pull_done
}

clone_or_pull_fzf
