#!/usr/bin/env bash

clone_or_pull_tmux() {
  msg info "installing tmux"
  clone_or_pull "tmux/tmux"
  msg info "autogen.sh"
  sh autogen.sh >/dev/null 2>&1
  msg info "./configure"
  ./configure >/dev/null 2>&1
  msg info "make"
  make >/dev/null 2>&1
  msg info "make install"
  sudo make install >/dev/null 2>&1
  clone_or_pull_done

  whereis tmux
  tmux -V
}

clone_or_pull_tmux
