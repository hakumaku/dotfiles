#!/usr/bin/env bash

install_essentials() {
  local packages=(
    "git" "xclip" "figlet"
    "apt-transport-https" "ca-certificates" "software-properties-common"
    "gnupg" "build-essential" "wget" "curl" "autoconf" "automake"
    "python3" "python-is-python3" "python3-pip" "python3-distutils"
    "cargo" "npm" "snap" "stow")
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

  # Specify XDG base directory specification variables
  cat <<EOT >>"$HOME/.pam_environment"
XDG_CACHE_HOME  DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME DEFAULT=@{HOME}/.config
XDG_DATA_HOME   DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME  DEFAULT=@{HOME}/.local/state
CARGO_HOME      DEFAULT=${XDG_DATA_HOME}/cargo
RUSTUP_HOME     DEFAULT=${XDG_DATA_HOME}/rustup
PYLINTHOME      DEFAULT=${XDG_CACHE_HOME}/pylint
EOT
}

install_essentials
pushd $XDG_DATA_HOME/ubuntu-fresh 
stow --target=$HOME dotfiles
popd
