#!/usr/bin/env bash

install_numix() {
  sudo add-apt-repository ppa:numix/ppa
  sudo apt -qq -y update
  sudo apt -qq install numix-icon-theme-circle
}

install_numix
