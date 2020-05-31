#!/usr/bin/env bash

dotfiles="$HOME/workspace/ubuntu-fresh/dotfiles"

set_ssh() {
	ssh-keygen -t rsa -b 4096 -C "gentlebuuny@gmail.com" &&
		eval "$(ssh-agent -s)" &&
		ssh-add ~/.ssh/id_rsa &&
		git remote set-url origin "https://github.com/hakumaku/ubuntu-fresh" &&
		xclip -sel clip < ~/.ssh/id_rsa.pub &&
		firefox https://github.com/settings/ssh/new
}

sudo apt install git &&
	(cd && ln -s $dotfiles/git/.gitconfig)
