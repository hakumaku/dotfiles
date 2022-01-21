#!/usr/bin/env bash

install_extra_packages() {
  local python_packages=(
    "autopep8"
    "black"
    "cmake-format"
    "cmake-language-server"
    "flake8"
    "isort"
    "pynvim"
  )
  local npm_packages=(
    "bash-language-server"
    "pyright"
  )

  msg info "installing extra packages for nvim"
  if ! command -v clang &>/dev/null; then
    pip install --quiet --user --upgrade ${python_packages[@]}
    sudo npm install --silent --global ${npm_packages[@]}
  else
    pip install --quiet --user --upgrade ${python_packages[@]}
    sudo npm update --silent ${npm_packages[@]}
  fi
}

clone_or_pull_sumneko_lua() {
  local dest="$HOME/.cache/nvim/lspconfig/sumneko_lua/lua-language-server"
  clone_or_pull "sumneko/lua-language-server" "$dest" true
  local cwd="$PWD"
  msg info "./compile/install.sh"
  cd $cwd/3rd/luamake
  ./compile/install.sh >/dev/null 2>&1
  cd $cwd
  msg info "./3rd/luamake/luamake"
  ./3rd/luamake/luamake rebuild >/dev/null 2>&1
  clone_or_pull_done
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

fetch_from_git_shfmt() {
  local tmpdir=$(dirname $(mktemp -u))
  if command -v shfmt &>/dev/null; then
    local local_version=$(shfmt --version)
    fetch_from_git "mvdan/sh" \
      "shfmt_v.*_linux_amd64" \
      $tmpdir \
      $local_version
  else
    fetch_from_git "mvdan/sh" \
      "shfmt_v.*_linux_amd64" \
      $tmpdir
  fi

  local output="$(compgen -G $tmpdir/shfmt_*)"
  if [[ -f $output ]]; then
    local dir="$HOME/.local/bin"
    msg info "copying binary file to $dir"
    mv $output $dir/shfmt
    chmod +x $dir/shfmt
  fi
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
fetch_from_git_shfmt
clone_or_pull_sumneko_lua
clone_or_pull_lua_formatter
clone_or_pull_nvim
