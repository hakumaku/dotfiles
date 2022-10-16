#!/usr/bin/env bash

change_grub_resolution() {
  local path="/etc/default/grub"
  sudo sed -i 's/#GRUB_GFXMODE=.*/GRUB_GFXMODE=1280x800/' $path
}

change_grub_resolution
