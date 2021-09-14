#!/usr/bin/env bash

install_essentials() {
  # Check if it's run once previously.
  if command -v tmux &>/dev/null; then
    return
  fi

  sudo add-apt-repository ppa:lazygit-team/release
  local packages=(
    "git" "lazygit" "xclip" "figlet" "tmux"
    "apt-transport-https" "ca-certificates" "software-properties-common"
    "gnupg" "build-essential" "wget" "curl" "autoconf" "automake"
    "python3" "python-is-python3" "python3-pip" "python3-distutils" "npm" "stow")
  sudo apt install ${packages[@]}

  # Install rust
  export CARGO_HOME=${HOME}/.local/share/cargo
  export RUSTUP_HOME=${HOME}/.local/share/rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # Install nodejs
  sh -c 'curl -sL install-node.now.sh/lts | sudo bash'

  # Specify XDG base directory specification variables
  cat <<EOT >>"$HOME/.pam_environment"
XDG_CACHE_HOME  DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME DEFAULT=@{HOME}/.config
XDG_DATA_HOME   DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME  DEFAULT=@{HOME}/.local/state
CARGO_HOME      DEFAULT=\${XDG_DATA_HOME}/cargo
RUSTUP_HOME     DEFAULT=\${XDG_DATA_HOME}/rustup
PYLINTHOME      DEFAULT=\${XDG_CACHE_HOME}/pylint
EOT
}

install_essentials
pushd $SCRIPT_HOME
stow --target=$HOME dotfiles
popd
