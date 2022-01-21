#!/usr/bin/env bash

install_mpv() {
  install_package mpv

  whereis mpv
  mpv --version
  # TODO: pull 4k plugin
}

install_mpv
