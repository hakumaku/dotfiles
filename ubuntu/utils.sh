#!/usr/bin/env bash

bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" &&
sudo apt install cargo make &&
    cargo install --locked exa fd-find bat ytop &&
    # Add $HOME/.cargo to $PATH variable.
    [ -f "$HOME/.profile" ] && cat <<EOT >> "$HOME/.profile"

# Add .cargo path to \$PATH variable
if [ -d "\$HOME/.cargo" ]; then
    PATH="\$HOME/.cargo/bin:\$PATH"
fi
EOT
