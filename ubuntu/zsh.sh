#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"
workspace="$HOME/workspace"

install_zsh_extensions() {
	# powerlevel 10k
	local url="https://github.com/romkatv/powerlevel10k.git"
	git clone --depth=1 "$url" "$workspace/${url##*/}"

	# zsh-syntax-highlighting
	url="https://github.com/zsh-users/zsh-syntax-highlighting.git"
	git clone "$url" "$workspace/${url##*/}"

	# zsh-dircolors-solarized
	url="https://github.com/joel-porquet/zsh-dircolors-solarized"
	git clone --recursive "$url" "$workspace/${url##*/}"

	url="https://github.com/zsh-users/zsh-autosuggestions"
	git clone "$url" "$workspace/${url##*/}"
}

sudo apt install zsh &&
	chsh -s $(which zsh) &&
	(cd && ln -s $dotfile/zsh/.zshrc &&
	ln -s $dotfile/zsh/.p10k.zsh)

install_zsh_extensions
