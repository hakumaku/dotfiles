#!/usr/bin/env bash

install_utilities() {
  local packages=("git-delta" "exa" "bat" "fd-find" "ripgrep" "bottom")
  cargo install ${packages[@]}
}

install_alacritty() {
  local url="https://github.com/alacritty/alacritty.git"
  local dir="${prefix}/alacritty"

  if [ -d "$dir" ]; then
    git -C $dir pull
    cd "$dir" && build_alacritty
  else
    local dependencies=("pkg-config" "libfreetype6-dev" "libfontconfig1-dev" "libxcb-xfixes0-dev")
    # Fresh install
    git clone $url "$dir"
    sudo apt install ${dependencies[@]}
    cd "$dir" && build_alacritty
    (mkdir -p ~/.config && cd ~/.config && ln -s $dotfile/alacritty)
  fi
}

build_alacritty() {
  cargo build --release
  # Install binaries
  sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database -q
  # Manual Page
  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
  # Shell Completions
  mkdir -p ${ZDOTDIR:-~}/.zsh_functions
  echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc
  cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
}

install_utilities
install_alacritty
