#!/usr/bin/env bash

scale_gdm() {
  local config="/etc/gdm3/greeter.dconf-defaults"
  sudo sed -i '/\[org\/gnome\/desktop\/interface\]/a scaling-factor=uint32 2' $config
}

scale_qt() {
  echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment
  echo "QT_AUTO_SCREEN_SCALE_FACTOR=0" | sudo tee -a /etc/environment
  echo "QT_SCALE_FACTOR=2.0" | sudo tee -a /etc/environment
}

scale_gdm
scale_qt
