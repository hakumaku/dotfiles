append_path() {
  case ":$PATH:" in
    *:"$1":*) ;;
    *)
      PATH="${PATH:+$PATH:}$1"
      ;;
  esac
}
append_path "$HOME/.local/bin"
append_path "$HOME/.local/share/cargo/bin"

# dotfiles
[[ -d $HOME/.config/X11 ]] && xrdb -merge $HOME/.config/X11/.Xresources
