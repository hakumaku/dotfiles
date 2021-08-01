#!/usr/bin/env bash

install_popshell() {
  local dest="${prefix}/shell"
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
  local gsettings_set_shell="gsettings set org.gnome.shell.extensions.pop-shell"
  $gsettings_set_shell tile-enter ['<Super>Space']

  # $gsettings_set_shell pop-monitor-right ['<Super><Shift>Right', '<Super><Shift>KP_Right', '<Super><Shift>l']
  # $gsettings_set_shell gap-outer uint32 4
  # $gsettings_set_shell gap-inner uint32 4
  # $gsettings_set_shell row-size uint32 64
  # $gsettings_set_shell pop-workspace-down ['<Super><Shift>Down', '<Super><Shift>KP_Down', '<Super><Shift>j']
  # $gsettings_set_shell activate-launcher ['<Super>slash']
  # $gsettings_set_shell tile-move-left ['Left', 'KP_Left', 'h']
  # $gsettings_set_shell show-title false
  # $gsettings_set_shell focus-left ['<Super>Left', '<Super>KP_Left', '<Super>h']
  # $gsettings_set_shell tile-resize-left ['<Shift>Left', '<Shift>KP_Left', '<Shift>h']
  # $gsettings_set_shell tile-by-default true
  # $gsettings_set_shell toggle-tiling ['<Super>y']
  # $gsettings_set_shell pop-monitor-down ['<Super><Shift><Primary>Down', '<Super><Shift><Primary>KP_Down', '<Super><Shift><Primary>j']
  # $gsettings_set_shell toggle-stacking-global ['<Super>s']
  # $gsettings_set_shell tile-accept ['Return', 'KP_Enter']
  # $gsettings_set_shell focus-right ['<Super>Right', '<Super>KP_Right', '<Super>l']
  # $gsettings_set_shell toggle-floating ['<Super>g']
  # $gsettings_set_shell tile-move-down ['Down', 'KP_Down', 'j']
  # $gsettings_set_shell active-hint false
  # $gsettings_set_shell show-skip-taskbar true
  # $gsettings_set_shell tile-resize-up ['<Shift>Up', '<Shift>KP_Up', '<Shift>k']
  # $gsettings_set_shell focus-down ['<Super>Down', '<Super>KP_Down', '<Super>j']
  # $gsettings_set_shell tile-resize-down ['<Shift>Down', '<Shift>KP_Down', '<Shift>j']
  # $gsettings_set_shell hint-color-rgba 'rgba(251, 184, 108, 1)'
  # $gsettings_set_shell pop-monitor-up ['<Super><Shift><Primary>Up', '<Super><Shift><Primary>KP_Up', '<Super><Shift><Primary>k']
  # $gsettings_set_shell management-orientation ['o']
  # $gsettings_set_shell pop-workspace-up ['<Super><Shift>Up', '<Super><Shift>KP_Up', '<Super><Shift>k']
  # $gsettings_set_shell tile-swap-left ['<Primary>Left', '<Primary>KP_Left', '<Primary>h']
  # $gsettings_set_shell smart-gaps false
  # $gsettings_set_shell tile-resize-right ['<Shift>Right', '<Shift>KP_Right', '<Shift>l']
  # $gsettings_set_shell column-size uint32 64
  # $gsettings_set_shell tile-reject ['Escape']
  # $gsettings_set_shell toggle-stacking ['s']
  # $gsettings_set_shell tile-orientation ['<Super>o']
  # $gsettings_set_shell log-level uint32 0
  # $gsettings_set_shell tile-swap-down ['<Primary>Down', '<Primary>KP_Down', '<Primary>j']
  # $gsettings_set_shell focus-up ['<Super>Up', '<Super>KP_Up', '<Super>k']
  # $gsettings_set_shell snap-to-grid false
  # $gsettings_set_shell tile-swap-right ['<Primary>Right', '<Primary>KP_Right', '<Primary>l']
  # $gsettings_set_shell tile-swap-up ['<Primary>Up', '<Primary>KP_Up', '<Primary>k']
  # $gsettings_set_shell tile-move-up ['Up', 'KP_Up', 'k']
  # $gsettings_set_shell tile-move-right ['Right', 'KP_Right', 'l']
  # $gsettings_set_shell pop-monitor-left ['<Super><Shift>Left', '<Super><Shift>KP_Left', '<Super><Shift>h']
}

install_popshell
update_shortcuts
