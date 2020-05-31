#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

sudo add-apt-repository ppa:mmstick76/alacritty &&
	sudo apt install alacritty &&
	(mkdir -p ~/.config/alacritty && cd ~/.config/alacritty &&
		ln -s $dotfile/alacritty/alacritty.yml)
