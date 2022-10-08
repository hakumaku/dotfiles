#!/usr/bin/env bash

set -euo pipefail

install_extra_packages() {
  msg info "installing extra packages for nvim"
  install_python_dev
  install_typescript_dev
  # install_devops_dev
}

clone_or_pull_lua_formatter() {
  clone_or_pull "Koihik/LuaFormatter.git" "" true
  local cwd="$PWD"
  msg info "cmake"
  cmake -S "$cwd" -B "$cwd/build" >/dev/null 2>&1
  msg info "cmake --build"
  cmake --build "$cwd/build" -j 8 >/dev/null 2>&1
  msg info "cmake --install"
  sudo -E env "PATH=$PATH" cmake --install "$cwd/build"
  clone_or_pull_done
}

install_python_dev() {
  local python_packages=()
  get_packge_list pip python_packages
  msg info "pip: ${python_packages[*]}"
  msg info "updating pip"
  pip install --quiet --user --upgrade pip ${python_packages[@]}
}

install_typescript_dev() {
  if [[ ! -f "${XDG_CONFIG_HOME}/nvm/nvm.sh" ]]; then
    msg info "installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install node
  fi

  local npm_packages=()
  get_packge_list npm npm_packages
  msg info "npm: ${npm_packages[*]}"
  msg info "updating npm"
  export NVM_DIR=$(printf %s "${XDG_CONFIG_HOME}/nvm")
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    PREFIX= . "$NVM_DIR/nvm.sh"
  else
    msg error "cannot load nvm.sh"
  fi

  local cmd=""
  if ! command -v prettier &>/dev/null; then
    cmd="install"
  else
    cmd="update"
  fi
  npm ${cmd} --silent --location=global npm@latest ${npm_packages[@]}
}

install_devops_dev() {
  local packages=(
    "terraform"
    "kubectl"
    "k9s"
  )
  local aur_packages=(
    "terraform-docs-bin.git"
    "terraform-lsp.git"
  )

  for pkg in ${aur_packages[@]}; do
    msg info "installing $pkg"
    clone_or_pull_aur $pkg
    makepkg --syncdeps --install --log --noprogressbar --noconfirm
    clone_or_pull_done
  done

  sudo pacman -Syq ${packages[@]}

  pip install --quiet --user awscliv2
}

install_cpp_dev() {
  # TODO: gdb, clang, lldb
  echo "TODO!"
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
  sudo -E env "PATH=$PATH" make install >/dev/null 2>&1
  clone_or_pull_done

  nvim +PackerSync

  whereis nvim
  nvim --version
}

install_extra_packages
clone_or_pull_lua_formatter
clone_or_pull_nvim
