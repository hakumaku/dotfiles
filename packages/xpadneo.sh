#!/usr/bin/env bash

set -euo pipefail

install_xpadneo() {
  msg info "xpadneo"
  clone_or_pull "atar-axis/xpadneo"
  install_dependencies xpadneo
  sudo ./install.sh
  clone_or_pull_done
}

install_xpadneo
