#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

sudo apt install rofi &&
    cd $HOME/.config && ln -s $dotfile/rofi

