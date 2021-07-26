#!/usr/bin/env bash

# C/C++
install_cpp() {
  # TODO: auto version detection
  local version="12"
  local packages=(
    "clang-${version}" "libclang-${version}-dev" "libclang-cpp${version}-dev"
    "clang-tools-${version}" "clang-format-${version}" "clang-tidy-${version}")
  # Install latest clang
  sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
  sudo apt install ${packages[@]}
  sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${version} 100
  sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
  sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
  sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
  sudo update-alternatives --install /usr/bin/lldb-vscode lldb-vscode /usr/bin/lldb-vscode-${version} 100
}

# Lua
# sumneko_lua, LuaFormatter
install_lua_lsp() {
  local dest="$HOME/.cache/nvim/lspconfig/sumneko_lua/lua-language-server"
  if [ ! -d "$dest" ]; then
    mkdir -p "$HOME/.cache/nvim/lspconfig/sumneko_lua"
    # Fresh install
    local url="https://github.com/sumneko/lua-language-server"
    git clone --recurse-submodules $url $dest
  else
    # git pull and rebuild
    git -C $dest pull
  fi

  cd $dest/3rd/luamake
  ./compile/install.sh
  cd $dest
  ./3rd/luamake/luamake rebuild
}

install_lua_formatter() {
  local dest="${prefix}/LuaFormatter"
  if [ ! -d "$dest" ]; then
    # Fresh install
    local url="https://github.com/Koihik/LuaFormatter.git"
    git clone --recurse-submodules $url $dest
  else
    # git pull and rebuild
    git -C $dest pull
  fi
  cmake -S "$dest" -B "$dest/build"
  cmake --build "$dest/build" -j 8
  sudo cmake --install "$dest/build"
}

install_lua() {
  install_lua_lsp
  install_lua_formatter
}

install_nvim() {
  local dest="${prefix}/neovim"
  if [ ! -d "$dest" ]; then
    local dependencies=(
      "ninja-build" "gettext" "libtool" "libtool-bin"
      "autoconf" "automake" "pkg-config" "unzip")
    sudo apt install ${dependencies[@]}
    git clone "https://github.com/neovim/neovim" $dest
    local packer="https://github.com/wbthomason/packer.nvim"
    local packer_dest="~/.local/share/nvim/site/pack/packer/start/packer.nvim"
    git clone $packer $packer_dest 
  else
    git -C $dest pull
  fi

  cd $dest
  make MIN_LOG_LEVEL=1 CMAKE_BUILD_TYPE=Release
  sudo make install
  if [ ! -d "$dest" ]; then
    nvim +PackerInstall +qall
    nvim +PackerCompile +qall
  else
    nvim +PackerSync +qall
  fi
}

install_external_dependencies() {
  # Python, CMake, Lua, Bash
  local python_packages=("pynvim" "autopep8" "isort" "cmake-language-server" "cmake-format")
  local npm_packages=("pyright" "bash-language-server")
  local snap_packages=("shfmt")

  if ! command -v clang &>/dev/null; then
    install_cpp
    pip3 install --upgrade ${python_packages[@]}
    npm install --global ${npm_packages[@]}
    sudo snap install ${snap_packages}
    install_lua
  else
    pip3 install --upgrade ${python_packages[@]}
    npm update ${npm_packages[@]}
    sudo snap refresh ${snap_packages}
    install_lua
  fi
}

install_external_dependencies
install_nvim
