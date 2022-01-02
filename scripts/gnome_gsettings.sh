#!/usr/bin/env bash

# Desktop
gsettings set org.gnome.desktop.background show-desktop-icons 'false'
gsettings set org.gnome.desktop.background picture-options 'wallpaper'
gsettings set org.gnome.desktop.screensaver picture-options 'wallpaper'
gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
gsettings set org.gnome.desktop.interface clock-show-date 'true'
gsettings set org.gnome.desktop.interface clock-show-weekday 'true'
gsettings set org.gnome.desktop.interface clock-show-seconds 'true'

# Interface
gsettings set org.gnome.desktop.interface enable-hot-corners 'false'
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar false
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.privacy recent-files-max-age -1
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# Extensions
SCHEMADIR="$HOME/.local/share/gnome-shell/extensions"
for dir in $SCHEMADIR/dash-to-dock*; do
  if [ -d "$dir" ]; then
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock apply-custom-theme 'false'
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink 'true'
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock customize-alphas true
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock background-opacity 0.3
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock max-alpha 0.2

    # <Super>Q: dash-to-dock
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock hot-keys false
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock shortcut-text ""
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock shortcut "[]"

    # Set all false to hide ubuntu dash-to-dock
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock autohide false
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock intellihide true
  fi
  break
done

for dir in $SCHEMADIR/drawOnYourScreen*; do
  if [ -d "$dir" ]; then
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.draw-on-your-screen erase-drawing "['<Alt>space']"
    gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.draw-on-your-screen toggle-drawing "['<Super>space']"
  fi
  break
done

# Keyboard shortcuts
gsettings set org.gnome.desktop.input-sources xkb-options "['korean:ralt_rctrl', 'caps:ctrl_modifier']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>f']"

# Disable default bindings.
# <Super>: overlay key
gsettings set org.gnome.mutter overlay-key ""
# <Super>A: application view
gsettings set org.gnome.shell.keybindings toggle-application-view "[]"
# <Super>N: focus-active-notification
gsettings set org.gnome.shell.keybindings focus-active-notification "[]"
# <Super>H: Hide window
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
# <Super>L: Screensaver
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "[]"
# <Super>P: switch-monitor
gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
# <Super>Above_Tab: switch-group
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Alt>Above_Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
# <Super>S: toggle-overview
gsettings set org.gnome.shell.keybindings toggle-overview "[]"
# <Super>Escape: Restore the keyboard shortcuts
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "[]"
# <Super>space: switch-input-source
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
# <Alt>space: window menu
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"
# Gnome-shell debug
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>slash']"

# Window tiling keybindings
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>H']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>L']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>K']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>J']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>,']"

# Switching workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>N']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>P']"

# Move window to another workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Super><Ctrl>N']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Super><Ctrl>P']"

# Move window to another monitor
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Super><Ctrl>H']"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Super><Ctrl>L']"

# Close window
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>Q', '<Alt>F4']"
# Disable animation
gsettings set org.gnome.desktop.interface enable-animations true

# Switching to specific workspace
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['']"
# gsettings set org.gnome.shell.keybindings switch-to-application-7 "['']"
# gsettings set org.gnome.shell.keybindings switch-to-application-8 "['']"
# gsettings set org.gnome.shell.keybindings switch-to-application-9 "['']"

# Move window to specific workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Ctrl>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Ctrl>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Ctrl>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Ctrl>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Super><Ctrl>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Ctrl>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Super><Ctrl>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Super><Ctrl>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Super><Ctrl>9']"

# Mouse settings
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

# Sound control
# Unlike 'wm', media-keys does not support
# list of multiple keys, but string only.
# Thus, the audio keys, such as 'XF86AudioRaiseVolume',
# which some keyboards have will be disabled.
# I have tried to bind these keys to custom-keybindings to run 'amixer',
# but it did not go well. The commands were:
# 'amixer set Master 3%+'
# 'amixer -q sset Master 3%+'
# 'amixer -q -D pulse sset Master 10%+'
# 'amixer -M get Master'
# 'pactl set-sink-volume 0 +15%'
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Super>equal']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Super>minus']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['<Super>0']"
