#!/usr/bin/env bash

# GNOME Shell
gsettings set org.gnome.desktop.interface scaling-factor 2
# GDM
config="/etc/gdm3/greeter.dconf-defaults"
sudo sed -i '/\[org\/gnome\/desktop\/interface\]/a scaling-factor=uint32 2' $config
