#!/usr/bin/env bash

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

install_dev_utilities

