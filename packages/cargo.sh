#!/usr/bin/env bash

set -euo pipefail

install_cargo_utilities() {
  if ! command -v rustup &>/dev/null; then
    msg info "installing rustup"
    export CARGO_HOME=${HOME}/.local/share/cargo
    export RUSTUP_HOME=${HOME}/.local/share/rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi

  whereis cargo
  cargo --version
}

