#!/usr/bin/env bash

install_essentials() {
  # Check if it's run once previously.
  if command -v tmux &>/dev/null; then
    return
  fi

  local packages=(
    "git" "xclip" "figlet" "tmux"
    "apt-transport-https" "ca-certificates" "software-properties-common"
    "gnupg" "build-essential" "wget" "curl" "autoconf" "automake"
    "python3" "python-is-python3" "python3-pip" "python3-distutils" "npm" "stow")
  sudo apt install ${packages[@]}

  # Install nodejs
  sh -c 'curl -sL install-node.now.sh/lts | sudo bash'

  # Specify XDG base directory specification variables
  cat <<EOT >>"$HOME/.pam_environment"
VISUAL          DEFAULT=/usr/local/bin/nvim
EDITOR          DEFAULT=/usr/local/bin/nvim
XDG_CACHE_HOME  DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME DEFAULT=@{HOME}/.config
XDG_DATA_HOME   DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME  DEFAULT=@{HOME}/.local/state
GTK2_RC_FILES   DEFAULT=\${XDG_CONFIG_HOME}/gtk-2.0/gtkrc
CARGO_HOME      DEFAULT=\${XDG_DATA_HOME}/cargo
RUSTUP_HOME     DEFAULT=\${XDG_DATA_HOME}/rustup
PYLINTHOME      DEFAULT=\${XDG_CACHE_HOME}/pylint
EOT
}

install_essentials
pushd $SCRIPT_HOME
stow --target=$HOME dotfiles
popd
