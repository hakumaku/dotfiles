#!/usr/bin/env bash

# sudo apt install cargo llvm libclang-dev &&
# 	cargo install --locked exa fd-find bat &&
	# Add $HOME/.cargo to $PATH variable.
	[ -f "$HOME/.profile" ] && cat <<EOT >> "$HOME/.profile"

# Add .cargo path to \$PATH variable
if [ -d "$HOME/.cargo" ]; then
    path="\$HOME/.cargo/bin:\$PATH"
fi
EOT
