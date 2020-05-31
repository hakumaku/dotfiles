#!/usr/bin/env bash

dotfiles="$HOME/workspace/ubuntu-fresh/dotfiles"

sudo apt install git &&
	(cd && ln -s $dotfiles/git/.gitconfig)
