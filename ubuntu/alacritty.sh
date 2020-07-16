#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

sudo add-apt-repository ppa:mmstick76/alacritty &&
	sudo apt install alacritty &&
	(mkdir -p ~/.config && cd ~/.config && ln -s $dotfile/alacritty)
