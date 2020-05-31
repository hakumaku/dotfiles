#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

install_tmux_theme() {
	local url="https://github.com/jimeh/tmux-themepack.git"
	git clone -q "$url" ~/.tmux-themepack
}

sudo apt install tmux &&
	install_tmux_theme &&
	(cd && ln -s $dotfile/tmux/.tmux.conf)
