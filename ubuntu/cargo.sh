#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"
workspace="$HOME/workspace"

install_dev_utilities() {
	local packages=("git-delta" "bat" "fd-find" "ripgrep")
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

install_alacritty() {
	local dependencies=("pkg-config" "libfreetype6-dev" "libfontconfig1-dev" "libxcb-xfixes0-dev")
	git clone https://github.com/alacritty/alacritty.git "${workspace}/alacritty" &&
		sudo apt install ${dependencies[@]} &&
		cd "${workspace}/alacritty" && cargo build --release &&
		post_build_alacritty &&
		(mkdir -p ~/.config && cd ~/.config && ln -s $dotfile/alacritty)
}

post_build_alacritty() {
	cd "${workspace}/alacritty" 
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database
	sudo mkdir -p /usr/local/share/man/man1
	gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
	mkdir -p ${ZDOTDIR:-~}/.zsh_functions
	echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
	cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
}

install_dev_utilities &&
	install_alacritty &&
	post_build_alacritty

