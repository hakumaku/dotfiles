# Get dpi for Xresources.
resolution=$(xrandr --query | grep " connected" | awk '{print $4}')
if [[ "$resolution" == "3840x2160"* ]]; then
  dpi="192"
  if ! [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    # If it is not gnome-shell, set GDK env variables.
    export GDK_SCALE=2.0
    export GDK_DPI_SCALE=0.5
  fi
elif [[ "$resolution" == "2560x1440"* ]]; then
  dpi="144"
else # 1920x1080
  dpi="96"
fi

set_env_if_not_set() {
  local -n key=$1
  local value=$2
  export key=${key:="$value"}
}
set_env_if_not_set DESKTOP_SESSION "gnome"
set_env_if_not_set XDG_CURRENT_DESKTOP "GNOME"
set_env_if_not_set GTK_THEME "Adwaita:dark"

# dotfiles
if [[ $XDG_SESSION_TYPE != "wayland" ]]; then
  # Xorg
  [[ -d $XDG_CONFIG_HOME/X11 ]] && xrdb -DXFT_DPI=$dpi -merge $XDG_CONFIG_HOME/X11/.Xresources
else
  # wayland
  echo "foo"
fi
