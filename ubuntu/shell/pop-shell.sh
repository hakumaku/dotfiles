#!/usr/bin/env bash

install_popshell() {
  local dest="${PREFIX}/shell"
  if [ ! -d "$dest" ]; then
    # Fresh install
    sudo apt install node-typescript
    local url="https://github.com/pop-os/shell"
    git clone $url $dest
  else
    # git pull and rebuild
    git -C $dest pull
  fi

  cd $dest
  make local-install
  # Update gsettings schemas
  local glib_schema="$HOME/.local/share/glib-2.0/schemas"
  local shell_schema="$HOME/.local/share/gnome-shell/extensions/pop-shell@system76.com/schemas/"
  mkdir -p $glib_schema
  cp -rf $shell_schema/* $glib_schema
}

update_shortcuts() {
  local schemas="/org/gnome/shell/extensions/pop-shell"
  dconf write "$schemas/active-hint" true
  dconf write "$schemas/gap-inner" "uint32 4"
  dconf write "$schemas/gap-outer" "uint32 4"
  dconf write "$schemas/show-title" false
  dconf write "$schemas/tile-by-default" true
  dconf write "$schemas/tile-enter" "['<Super>Space']"
  dconf write "$schemas/hint-color-rgba" "'rgba(233, 84, 32, 1)'"
  dconf write "$schemas/activate-launcher" "['<Super>R']"

  dconf write "/org/gnome/mutter/keybindings/toggle-tiled-right" "['']"
  dconf write "/org/gnome/mutter/keybindings/toggle-tiled-left" "['']"
  dconf write "/org/gnome/settings-daemon/plugins/media-keys/home" "['<Super>f']"
  dconf write "/org/gnome/desktop/wm/keybindings/panel-run-dialog" "['<Super>slash']"
}

install_popshell
update_shortcuts
