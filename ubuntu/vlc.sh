#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

sudo apt install vlc ffmpeg &&
	(mkdir -p $HOME/.config/vlc && cd $HOME/.config/vlc &&
	rm -f vlcrc && ln -s $dotfile/vlc/vlcrc)
