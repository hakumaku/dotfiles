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

set_env_if_not_set() {
  local -n key=$1
  local value=$2
  export key=${key:="$value"}
}
set_env_if_not_set DESKTOP_SESSION "gnome" 
set_env_if_not_set XDG_CURRENT_DESKTOP "GNOME" 
set_env_if_not_set GTK_THEME "Adwaita:dark" 

# dotfiles
[[ -d $HOME/.config/X11 ]] && xrdb -merge $HOME/.config/X11/.Xresources
