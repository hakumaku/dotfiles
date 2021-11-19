#!/usr/bin/env bash

export PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/ubuntu-fresh-sites"
export SCRIPT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/ubuntu-fresh"
export DISTRO=$(echo $(cat /etc/os-release | sed -rn "s/^NAME=\"(.*)\"/\1/p"))

set -euo pipefail

msg() {
  local type="$1"
  local msg="$2"
  case $type in
    title)
      printf "\e[1;36m%10s: %s\e[0m\n" "[target]" "${msg}"
      ;;
    progress)
      printf "\e[1;34m%10s: %s\e[0m\n" "[progress]" "${msg}"
      ;;
    info)
      printf "\e[1;32m%10s: %s\e[0m\n" "[info]" "${msg}"
      ;;
    warning)
      printf "\e[1;33m%10s: %s\e[0m\n" "[warning]" "${msg}"
      ;;
    error)
      printf "\e[1;31m%10s: %s\e[0m\n" "[error]" "${msg}"
      ;;
    *)
      echo "Invalid type in msg()"
      exit 1
      ;;
  esac
}

install_dependencies() {
  local dependencies=("$@")
  msg info "installing dependencies"
  case $DISTRO in
    "Ubuntu")
      sudo apt -qq install "${dependencies[@]}"
      ;;
    "Arch Linux")
      # TODO
      ;;
  esac
}

fetch_from_git() {
  local url="https://github.com/$1"
  local repository="${url##*/}"
  repository="${repository/.git/}"
  local expr="$2"
  local dest="$3"
  local local_version="$4"

  local link="$url/releases/$(curl -Ls "$url/releases/latest" | grep -wo "download/[v]\?.*/$expr")"
  if [[ ! -z $local_version ]]; then
    local remote_version=$(echo $link | sed -rn 's/.*\/v?(.*)\/.*/\1/p')

    if [[ $local_version = $remote_version ]] \
      || [[ $local_version = "v$remote_version" ]]; then
      msg info "$repository - already up to date ($remote_version)"
      return
    else
      msg info "$repository - upgrading to $remote_version from $local_version"
    fi
  fi

  local artifact=${link##*/}
  msg progress "downloading '$link'"
  curl --silent --location --output "$dest/$artifact" "$link"
  msg progress "$dest/$artifact"
}

clone_or_pull() {
  local url="https://github.com/$1"
  local repository="${url##*/}"
  repository="${repository/.git/}"

  local dest=${2:-"$PREFIX/$repository"}
  local submodule="$3"
  local args=""

  if [[ -z $dest ]]; then
    msg warning "directory does not exist"
    msg warning "$dest"
    mkdir -p $(dirname $dest)
  fi

  if [[ $submodule = "true" ]]; then
    args="--recurse-submodules"
  fi

  if [ ! -d "$dest" ]; then
    msg progress "cloning '$repository'"
    git clone --quiet $args "$url" "$dest"
  else
    msg progress "pulling '$repository'"
    git -C "$dest" pull --quiet $args
  fi

  # msg progress "entering directory '$dest'"
  pushd "$dest" >/dev/null
}

clone_or_pull_done() {
  # msg progress "leaving directory '$PWD'"
  popd >/dev/null
}

export -f msg
export -f fetch_from_git
export -f clone_or_pull
export -f clone_or_pull_done
export -f install_dependencies

main() {
  while [ $# -gt 0 ]; do
    local opt=$1
    shift

    echo ""
    case $opt in
      "info")
          msg title "info"
          echo "DISTRO: $DISTRO"
          ;;
      "cargo")
        msg title "cargo packages"
        exec ./develop/cargo.sh
        ;;
      "fcitx")
        msg title "fcitx"
        exec ./applications/fcitx.sh
        ;;
      "fonts")
        msg title "fonts"
        exec ./develop/fonts.sh
        ;;
      "fresh")
        # TODO
        # Also performs stow dotfiles
        exec ./develop/essentials.sh
        exec ./develop/cppdev.sh
        ;;
      "fzf")
        msg title "fzf"
        exec ./develop/fzf.sh
        ;;
      "icons")
        msg title 'change icons'
        exec ./icons/icons.sh "$@"
        ;;
      "lazygit")
        msg title 'lazygit'
        exec ./develop/lazygit.sh
        ;;
      "nvim" | "neovim")
        msg title 'neovim'
        exec ./develop/nvim.sh
        ;;
      "plank")
        msg title "plank"
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
        msg title 'ranger'
        exec ./develop/ranger.sh
        ;;
      "rofi")
        msg title 'rofi'
        exec ./develop/rofi.sh
        ;;
      "shell")
        # TODO
        msg title 'Pop Shell'
        exec ./shell/pop-shell.sh
        ;;
      "streamlink")
        msg title 'streamlink'
        exec ./applications/streamlink.sh
        ;;
      "youtube-dl" | "youtube" | "yt")
        msg title 'youtube-dl'
        exec ./applications/youtube-dl.sh
        ;;
      "vlc")
        msg title 'vlc'
        exec ./applications/vlc.sh
        ;;
      "xow")
        # TODO
        msg title 'xow'
        exec ./applications/xow.sh
        ;;
      "zsh")
        msg title 'zsh'
        exec ./develop/zsh.sh
        ;;
      *)
        echo "Unrecognized options: $opt"
        ;;
    esac
    msg title "done"
  done
}

main "$@"
