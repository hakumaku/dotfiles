#!/usr/bin/env bash

install_cmake() {
  if command -v cmake &>/dev/null; then
    return
  fi

  # local code=$(lsb_release -cs)
  local code="focal"
  if add-apt-repository -L | grep 'kitware' &>/dev/null; then
    sudo apt install cmake
  else
    local url="https://apt.kitware.com/keys/kitware-archive-latest.asc"
    local gpg="/usr/share/keyrings/kitware-archive-keyring.gpg"

    wget -O - $url 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
    sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ ${code} main"
    sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ ${code}-rc main"
  fi
}

install_clang() {
  if command -v clang &>/dev/null; then
    return
  fi
  
  # TODO: auto version detection
  local version="13"
  local code="hirsute"
  
  local packages=(
    "clang-${version}"
    "clangd-${version}"
    "clang-tools-${version}"
    "clang-format-${version}"
    # "python-clang-${version}"
    "clang-${version}-doc"
    "lldb-${version}"
    "libclang-common-${version}-dev"
    "libclang-${version}-dev"
    "libclang1-${version}"
  )
  # Install latest clang
  # sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
  local url="https://apt.llvm.org/llvm-snapshot.gpg.key"
  wget -O - $url 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/llvm.gpg >/dev/null
  sudo add-apt-repository "deb http://apt.llvm.org/${code}/ llvm-toolchain-${code}-${version} main"

  sudo apt install ${packages[@]}
  sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${version} 100
  sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100
  sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
  sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} 100
  sudo update-alternatives --install /usr/bin/lldb-vscode lldb-vscode /usr/bin/lldb-vscode-${version} 100
}

install_cmake
install_clang

# TODO
# sudo apt install linux-tools-$(uname -r) valgrind kcachegrind
# sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
# sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
# sudo sh -c 'echo kernel.perf_event_paranoid=1 >> /etc/sysctl.d/99-perf.conf'
# sudo sh -c 'echo kernel.kptr_restrict=0 >> /etc/sysctl.d/99-perf.conf'
# sudo sh -c 'sysctl --system'
