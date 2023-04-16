#!/usr/bin/env bash

export PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/repositories"
export SCRIPT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/$(basename $(git rev-parse --show-toplevel))"
export RESOURCE="$SCRIPT_HOME/resource"

export DISTRO=$(echo $(cat /etc/os-release | sed -rn "s/^NAME=\"(.*)\"/\1/p"))
case $DISTRO in
  "Arch Linux")
    DISTRO="arch"
    ;;
  "Ubuntu")
    DISTRO="ubuntu"
    ;;
esac

set -euo pipefail

# import common functions
source ./core/utils.sh

main() {
  assert_config
  msg info "${DISTRO} (${PREFIX})"

  while [ $# -gt 0 ]; do
    local opt=$1
    shift

    echo ""
    msg title "$opt"
    case $opt in
      "aur")
        if [[ "$DISTRO" != "arch" ]]; then
          msg error "'aur' only works on Arch Linux"
          exit 1
        fi
        exec ./arch/aur.sh
        ;;
      "cargo")
        exec ./packages/cargo.sh
        ;;
      "fcitx")
        exec ./packages/fcitx.sh
        ;;
      "fonts")
        exec ./packages/fonts.sh
        ;;
      "clang")
        exec ./$DISTRO/clang.sh
        ;;
      "firefox")
        exec ./packages/firefox.sh
        ;;
      "fzf")
        exec ./packages/fzf.sh
        ;;
      "icons")
        # TODO
        exec ./packages/icons.sh "$@"
        ;;
      "kitty")
        exec ./packages/kitty.sh
        ;;
      "lua")
        exec ./packages/lua.sh
        ;;
      "numix")
        exec ./$DISTRO/numix.sh
        ;;
      "nvim" | "neovim")
        exec ./packages/nvim.sh
        ;;
      "xpadneo" | "xbox")
        exec ./packages/xpadneo.sh
        ;;
      "zsh")
        exec ./packages/zsh.sh
        ;;
      *)
        msg error "unrecognized options: '$opt'"
        ;;
    esac
    msg title "done"
  done
}

main "$@"
