#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

install_dev_utilities() {
	local dependencies=("pkg-config" "libfreetype6-dev" "libfontconfig1-dev" "libxcb-xfixes0-dev")
	local packages=("alacritty", "git-delta" "bat" "fd-find" "ripgrep")
	sudo apt install cargo &&
		cargo install ${packages[@]}

	# Add $HOME/.cargo to $PATH variable.
	cat <<EOT >> "$HOME/.profile"

# Add cargo binary path to \$PATH variable
if [ -d "\$HOME/.cargo/bin" ]; then
    PATH="\$HOME/.cargo/bin:\$PATH"
fi
EOT
}

config_alacritty() {
	(mkdir -p ~/.config && cd ~/.config && ln -s $dotfile/alacritty)
}

install_dev_utilities && config_alacritty

