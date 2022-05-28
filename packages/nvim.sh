#!/usr/bin/env bash

set -euo pipefail

install_extra_packages() {
  local python_packages=(
    # mandatory
    "pynvim"

    # cmake
    "cmake-format"
    "cmake-language-server"

    # python-lsp
    "autopep8"
    "black"
    "flake8"
    "isort"
    "pyls-flake8"
    "pyls-isort"
    "pylsp-rope"
    "python-lsp-black"
    "python-lsp-server[all]"
  )
  local npm_packages=(
    "bash-language-server"
    "prettier"
  )
  # TODO: gdb, clang, lldb

  msg info "upgrading pip"
  pip install --quiet --user --upgrade pip
  if ! commnd -v nvm &>/dev/null; then
    msg info "installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install node
  fi
  msg info "upgrading npm"
  npm install --silent --location=global npm@latest

  msg info "installing extra packages for nvim"
  if ! command -v clang &>/dev/null; then
    pip install --quiet --user --upgrade ${python_packages[@]}
    npm install --silent --save-dev --save-exact --location=global ${npm_packages[@]}
  else
    pip install --quiet --user --upgrade ${python_packages[@]}
    npm update --silent --location=global ${npm_packages[@]}
  fi
}

clone_or_pull_lua_formatter() {
  clone_or_pull "Koihik/LuaFormatter.git" "" true
  local cwd="$PWD"
  msg info "cmake"
  cmake -S "$cwd" -B "$cwd/build" >/dev/null 2>&1
  msg info "cmake --build"
  cmake --build "$cwd/build" -j 8 >/dev/null 2>&1
  msg info "cmake --install"
  sudo cmake --install "$cwd/build" >/dev/null 2>&1
  clone_or_pull_done
}

clone_or_pull_nvim() {
  if ! command -v nvim &>/dev/null; then
    install_dependencies nvim

    local packer_dest="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
    mkdir -p $(dirname $packer_dest)
    clone_or_pull "wbthomason/packer.nvim" "$packer_dest"
  fi

  clone_or_pull "neovim/neovim"
  msg info "make"
  make MIN_LOG_LEVEL=1 CMAKE_BUILD_TYPE=Release >/dev/null 2>&1
  msg info "make install"
  sudo make install >/dev/null 2>&1
  clone_or_pull_done

  nvim +PackerSync

  whereis nvim
  nvim --version
}

install_extra_packages
clone_or_pull_lua_formatter
clone_or_pull_nvim
