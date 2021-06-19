#!/usr/bin/env bash

install_essentials() {
  local packages=(
    "git" "xclip" "figlet"
    "apt-transport-https" "ca-certificates" "software-properties-common"
    "gnupg" "build-essential" "wget" "curl" "autoconf" "automake"
    "python3" "python-is-python3" "python3-pip" "python3-distutils"
    "cargo" "npm" "snap")
  # Check if it's run once previously.
  if command -v cargo &>/dev/null; then
    return
  fi

  sudo apt install ${packages[@]}
  sh -c 'curl -sL install-node.now.sh/lts | sudo bash'

  # Add $HOME/.cargo to $PATH variable.
  cat <<EOT >>"$HOME/.profile"
# Add cargo binary path to \$PATH variable
if [ -d "\$HOME/.cargo/bin" ]; then
    PATH="\$HOME/.cargo/bin:\$PATH"
fi
EOT
}

install_essentials
