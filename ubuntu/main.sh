#!/usr/bin/env bash

export PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/ubuntu-fresh-sites"
export SCRIPT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/ubuntu-fresh"
set -euo pipefail

main() {
  while [ $# -gt 0 ]; do
    local opt=$1
    shift

    case $opt in
      "cargo")
        figlet 'Cargo packages'
        exec ./develop/cargo.sh
        ;;
      "fcitx")
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
          sed -Ei "s/#(TriggerKey=).*/\1HANGUL CTRL_SHIFT_SPACE/" "$config"
          sed -Ei "s/#(SwitchKey=).*/\1Disabled/" "$config"
          sed -Ei "s/#(IMSwitchKey=).*/\1False/" "$config"
          # Disable ctrl+5 key (ReloadConfig)
          sed -Ei "s/#(ReloadConfig=).*/\1/" "$config"
          # Disable ctrl+; key in fcitx-clipboard.config
          local clipboard="$conf/conf/fcitx-clipboard.config"
          sed -Ei "s/#(TriggerKey=).*/\1/" "$clipboard"
        else
          echo "Fcitx has already been installed."
        fi
        ;;
      "fonts")
        figlet 'Fonts'
        exec ./develop/fonts.sh
        ;;
      "fresh")
        # Also performs stow dotfiles
        exec ./develop/essentials.sh
        exec ./develop/cppdev.sh
        ;;
      "fzf")
        if [ ! -d "$PREFIX/fzf" ]; then
          git clone --depth 1 https://github.com/junegunn/fzf.git "$PREFIX/fzf"
        else
          git -C "$PREFIX/fzf" pull
        fi
        $PREFIX/fzf/install
        rm ~/.fzf.zsh
        rm ~/.fzf.bash
        ;;
      "icons")
        figlet 'Change Icons'
        exec ./icons/icons.sh "$@"
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
          exec plank &
          sleep 3s
        fi
        local schemas="/net/launchpad/plank/docks/dock1"
        dconf write "$schemas/alignment" "'center'"
        dconf write "$schemas/hide-mode" "'window-dodge'"
        dconf write "$schemas/icon-size" 64
        dconf write "$schemas/items-alignment" "'center'"
        dconf write "$schemas/position" "'bottom'"
        dconf write "$schemas/theme" "'Transparent'"
        dconf write "$schemas/zoom-enabled" true
        dconf write "$schemas/zoom-percent" 150
        ;;
      "ranger")
        figlet 'Ranger'
        exec ./develop/ranger.sh
        ;;
      "rofi")
        figlet 'Rofi'
        exec ./develop/rofi.sh
        ;;
      "shell")
        figlet 'Pop Shell'
        exec ./shell/pop-shell.sh
        ;;
      "streamlink")
        figlet 'Streamlink'
        if ! command -v streamlink &>/dev/null; then
          sudo add-apt-repository ppa:nilarimogard/webupd8
          cp $SCRIPT_HOME/scripts/twitch.desktop ${XDG_DATA_HOME:-$HOME/.local/share}/applications/
        fi
        local url="https://github.com/streamlink/streamlink-twitch-gui"
        local link=$(curl -Ls $url/releases/latest | grep -wo "download.*x86_64.AppImage")
        local output="${HOME}/.local/bin/streamlink-twitch-gui"
        curl -Lo $output "$url/releases/$link"
        chmod +x $output
        sudo apt install streamlink
        ;;
      "youtube-dl" | "youtube" | "yt")
        figlet 'Youtube-dl'
        if ! command -v youtube-dl &>/dev/null; then
          local bin="/usr/local/bin/youtube-dl"
          sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o $bin
          sudo chmod a+rx $bin
        else
          sudo youtube-dl -U
        fi
        ;;
      "vlc")
        figlet 'vlc'
        if ! command -v vlc &>/dev/null; then
          sudo apt install vlc ffmpeg
          mkdir -p $HOME/.config/vlc
        else
          echo "VLC has already been installed."
        fi
        ;;
      "xow")
        figlet 'xow'
        exec ./applications/xow.sh
        ;;
      "zsh")
        figlet 'Zsh'
        local repos=(
          "https://github.com/romkatv/powerlevel10k.git"
          "https://github.com/zsh-users/zsh-syntax-highlighting.git"
          "https://github.com/jeffreytse/zsh-vi-mode.git"
          "https://github.com/zsh-users/zsh-autosuggestions.git")
        if ! command -v zsh &>/dev/null; then
          sudo apt install zsh
          chsh -s $(which zsh)

          echo 'ZDOTDIR=$HOME/.config/zsh' | sudo tee -a /etc/zsh/zshenv
          for repo in ${repos[@]}; do
            repo_name="${repo##*/}"
            repo_name="${repo_name%.*}"
            git clone "$repo" "$PREFIX/${repo_name}"
          done
        else
          for repo in ${repos[@]}; do
            repo_name="${repo##*/}"
            repo_name="${repo_name%.*}"
            git -C "$PREFIX/${repo_name}" pull
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
