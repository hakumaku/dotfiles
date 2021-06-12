#!/usr/bin/env bash

set -euo pipefail

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

main() {
  export prefix="$HOME/workspace"
  export dotfile="$prefix/ubuntu-fresh/dotfiles"

  while [ $# -gt 0 ]; do
    local opt=$1
    shift

    case $opt in
      "cargo")
        figlet 'Cargo packages'
        exec ./develop/cargo.sh
        ;;
      "cmake")
        figlet 'CMake'
        exec ./develop/cmake.sh
        ;;
      "fonts")
        figlet 'Fonts'
        exec ./develop/fonts.sh
        ;;
      "fresh")
        figlet 'Fresh Setup'
        install_essentials
        ;;
      "git")
        figlet 'Git Setup'
        if [ ! -f ~/.ssh/id_rsa ]; then
          ssh-keygen -t rsa -b 4096 -C "gentlebuuny@gmail.com"
          eval "$(ssh-agent -s)"
          ssh-add ~/.ssh/id_rsa
          git remote set-url origin "https://github.com/hakumaku/ubuntu-fresh"
          xclip -sel clip <~/.ssh/id_rsa.pub
          sensible-browser "https://github.com/settings/ssh/new"
          (cd && ln -s $dotfile/git/.gitconfig)
        else
          echo "ssh already configured"
        fi
        ;;
      "git")
        figlet 'Fcitx'
        if ! command -v fcitx &>/dev/null; then
          # A bit buggy, don't know why yet.
          sudo apt install fcitx-hangul
          im-config -n fcitx
          local conf="$HOME/.config/fcitx"
          if [[ ! -d "$conf" ]]; then
            fcitx -d &
            sleep 3
          fi

          # Set input method
          local profile="$conf/profile"
          sed -Ei "s/#(IMName=)/\1Hangul/" "$profile"
          sed -Ei "s/(hangul:)False/\1True/" "$profile"
          # Disable some keys and set TriggerKey to 'hangul'
          local config="$conf/config"
          sed -Ei "s/#(TriggerKey=).*/\1HANGUL/" "$config"
          sed -Ei "s/#(SwitchKey=).*/\1Disabled/" "$config"
          sed -Ei "s/#(IMSwitchKey=).*/\1False/" "$config"
          # Disable ctrl+; key in fcitx-clipboard.config
          local clipboard="$conf/conf/fcitx-clipboard.config"
          sed -Ei "s/#(TriggerKey=).*/\1/" "$clipboard"
        else
          echo "Fcitx has already been installed."
        fi
        ;;
      "nvim" | "neovim")
        figlet 'Neovim'
        exec ./develop/nvim.sh
        ;;
      "plank")
        figlet 'Plank'
        if ! command -v plank &>/dev/null; then
          sudo apt remove gnome-shell-extension-ubuntu-dock
          sudo apt install plank
          (cd && ln -s $dotfile/plank)
        else
          echo "Plank has already been installed."
        fi
        ;;
      "ranger")
        figlet 'Ranger'
        exec ./develop/ranger.sh
        ;;
      "rofi")
        figlet 'Rofi'
        if ! command -v rofi &>/dev/null; then
          sudo apt install rofi
          (cd $HOME/.config && ln -s $dotfile/rofi)
        else
          echo "Rofi has already been installed."
        fi
        ;;
      "tmux")
        figlet 'Tmux'
        if ! command -v tmux &>/dev/null; then
          sudo apt install tmux
          (cd && ln -s $dotfile/tmux/.tmux.conf)
        else
          echo "Tmux has already been installed."
        fi
        ;;
      "youtube-dl" | "youtube" | "yt")
        figlet 'Youtube-dl'
        if ! command -v tmux &>/dev/null; then
          local bin="/usr/local/bin/youtube-dl"
          sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o $bin
          sudo chmod a+rx $bin
        else
          sudo youtube-dl -U
        fi
        ;;
      "vlc")
        figlet 'vlc'
        if ! command -v tmux &>/dev/null; then
          sudo apt install vlc ffmpeg
          mkdir -p $HOME/.config/vlc
          (cd $HOME/.config/vlc && rm -f vlcrc && ln -s $dotfile/vlc/vlcrc)
        else
          echo "VLC has already been installed."
        fi
        ;;
      "xow")
        figlet 'xow'
        exec ./develop/xow.sh
        ;;
      "zsh")
        figlet 'Zsh'
        local repos=(
          "https://github.com/romkatv/powerlevel10k.git"
          "https://github.com/zsh-users/zsh-syntax-highlighting.git"
          "https://github.com/zsh-users/zsh-autosuggestions")
        if ! command -v zsh &>/dev/null; then
          for repo in ${repos[@]}; do
            git clone "$repo" "$prefix/${repo##*/}"
          done

          sudo apt install zsh
          chsh -s $(which zsh)
          (cd && ln -s $dotfile/zsh/.zshrc && ln -s $dotfile/zsh/.p10k.zsh)
        else
          for repo in ${repos[@]}; do
            git -C "$prefix/${repo##*/}" pull
          done
        fi
        ;;
      *)
        echo "Unrecognized options: $opt"
        ;;
    esac
  done
}

main "$@"
