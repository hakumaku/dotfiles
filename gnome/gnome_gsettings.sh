#!/usr/bin/env bash

set_gsettings() {
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

  # Keyboard shortcuts
  gsettings set org.gnome.desktop.input-sources xkb-options "['korean:ralt_rctrl', 'caps:ctrl_modifier']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>E']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>w']"

  # Disable default bindings.
  gsettings set org.gnome.mutter overlay-key ""
  gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "[]"
  gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"

  # Gnome-shell
  gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>M']"
  gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>comma']"
  gsettings set org.gnome.shell.keybindings focus-active-notification "['<Super>period']"
  gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>semicolon']"

  gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
  gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"
  # Gnome-shell debug
  gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>slash']"

  # Window tiling keybindings
  gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>H']"
  gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>L']"
  gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"
  gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>K']"
  gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>J']"
  gsettings set org.gnome.desktop.wm.keybindings minimize "['']"
  gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Alt>Above_Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"

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
  gsettings set org.gnome.desktop.wm.preferences num-workspaces 8
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"
  gsettings set org.gnome.shell.keybindings switch-to-application-1 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-2 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-3 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-4 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-5 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-6 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-7 "['']"
  gsettings set org.gnome.shell.keybindings switch-to-application-8 "['']"
  # gsettings set org.gnome.shell.keybindings switch-to-application-9 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-1 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-2 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-3 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-4 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-5 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-6 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-7 "['']"
  gsettings set org.gnome.shell.keybindings open-new-window-application-8 "['']"
  # gsettings set org.gnome.shell.keybindings open-new-window-application-9 "['']"

  # Move window to specific workspace
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Ctrl>1']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Ctrl>2']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Ctrl>3']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Ctrl>4']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Super><Ctrl>5']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Ctrl>6']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Super><Ctrl>7']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Super><Ctrl>8']"
  # gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Super><Ctrl>9']"

  # Mouse settings
  gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
  gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

  # Sound control
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Super>equal']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-precise-static "['<Super><Ctrl>equal', '<Shift>XF86AudioRaiseVolume']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Super>minus']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-precise-static "['<Super><Ctrl>minus', '<Shift>XF86AudioLowerVolume']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['<Super>0']"

  # Explicitly set cursor-theme to `Adwaita` for flatpak apps
  gsettings set org.gnome.desktop.interface cursor-theme Adwaita

  gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>E']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>w']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys search "['<Super>r']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys email "['<Super>g']"
}

set_gsettings
