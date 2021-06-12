#!/usr/bin/env bash

install_docker() {
  if command -v docker &>/dev/null; then
    return
  fi

  local url="https://download.docker.com/linux/ubuntu/gpg"
  local source_list="deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  local dependencies=(
    "apt-transport-https" "ca-certificates"
    "curl" "gnupg" "lsb-release")
  sudo apt install ${dependencies[@]}
  curl -fsSL $url | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo $source_list | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io
}

install_docker
