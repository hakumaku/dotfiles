#!/usr/bin/env bash

install_clang() {
  if command -v clang &>/dev/null; then
    return
  fi
  
  # TODO: WIP
  # TODO: auto version detection
  local version="13"
  local code="hirsute"
  
  local packages=(
    "clang-${version}"
    "clangd-${version}"
    "clang-tidy-${version}"
    "clang-tools-${version}"
    "clang-format-${version}"
    "clang-${version}-doc"
    "lld-${version}"
    "lldb-${version}"
    "libclang-common-${version}-dev"
    "libclang-${version}-dev"
    "libclang1-${version}"
  )
  # Install latest clang
  local url="https://apt.llvm.org/llvm-snapshot.gpg.key"
  wget -O - $url 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/llvm.gpg >/dev/null
  sudo add-apt-repository "deb http://apt.llvm.org/${code}/ llvm-toolchain-${code}-${version} main"

  sudo apt install ${packages[@]}
  sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
  sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
  sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${version} 100
  sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
  sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${version} 100
  sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-${version} 100
  sudo update-alternatives --install /usr/bin/lldb-vscode lldb-vscode /usr/bin/lldb-vscode-${version} 100
}

install_clang

