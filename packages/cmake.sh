#!/usr/bin/env bash

install_cmake() {
  pip install --quiet --user cmake
  whereis cmake
  cmake --version
}

install_cmake
