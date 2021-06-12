#!/usr/bin/env bash

install_cmake() {
  local code="focal"

  if add-apt-repository -L | grep 'kitware' &>/dev/null; then
    sudo apt install cmake
  else
    local url="https://apt.kitware.com/keys/kitware-archive-latest.asc"
    wget -O - $url 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
    sudo add-apt-repository "deb https://apt.kitware.com/ubuntu/ ${code} main" \
      && sudo add-apt-repository "deb https://apt.kitware.com/ubuntu/ ${code}-rc main" \
      && sudo apt install kitware-archive-keyring
    sudo rm /etc/apt/trusted.gpg.d/kitware.gpg
  fi
}

install_cmake

# TODO
# sudo apt install linux-tools-$(uname -r) valgrind kcachegrind
# sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
# sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
# sudo sh -c 'echo kernel.perf_event_paranoid=1 >> /etc/sysctl.d/99-perf.conf'
# sudo sh -c 'echo kernel.kptr_restrict=0 >> /etc/sysctl.d/99-perf.conf'
# sudo sh -c 'sysctl --system'
