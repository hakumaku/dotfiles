#!/usr/bin/env bash

install_battlenet_dependencies() {
  local dependencies=(
    "winbind"
    "libgnutls30:i386" "libldap-2.4-2:i386"
    "libgpg-error0:i386" "libsqlite3-0:i386")
  sudo apt install ${dependencies[@]}
}

install_winehq_dependencies() {
  local dependencies=(
    "libgnutls30:i386" "libldap-2.4-2:i386" "libgpg-error0:i386"
    "libxml2:i386" "libasound2-plugins:i386" "libsdl2-2.0-0:i386"
    "libfreetype6:i386" "libdbus-1-3:i386" "libsqlite3-0:i386")
  local repo="deb https://dl.winehq.org/wine-builds/ubuntu/ focal main"
  sudo dpkg --add-architecture i386 \
    && wget -nc https://dl.winehq.org/wine-builds/winehq.key \
    && sudo apt-key add winehq.key \
    && sudo apt install ${dependencies[@]} \
    && sudo apt-add-repository "${repo}" \
    && sudo apt install --install-recommends winehq-stable
}

install_dxvk_dependencies() {
  # Install vulkan loader
  local dependencies=(
    "nvidia-driver-430" "libnvidia-gl-430" "libnvidia-gl-430:i386"
    "libvulkan1" "libvulkan1:i386")
  sudo apt install ${dependencies[@]}
}

sudo add-apt-repository ppa:lutris-team/lutris \
  && sudo apt install lutris && install_battlenet_dependencies \
  && install_winehq_dependencies \
  && install_dxvk_dependencies
