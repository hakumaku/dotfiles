#!/usr/bin/env bash
#
set -euo pipefail

change_config() {
  # TODO: intially lines are empty
  local path=""
  if [[ -d ~/.mozilla ]]; then
    path="$(find ~/.mozilla/firefox -name *.default-release -type d)/prefs.js"
  else
    path="$(find ~/snap/firefox/common/.mozilla/firefox -name *.default -type d)/prefs.js"
  fi

  if [[ ! -f $path ]]; then
      msg error $path
      exit 1
  fi

  local configs=(
    "toolkit.legacyUserProfileCustomizations.stylesheets"
    "layers.acceleration.force-enabled"
    "gfx.webrender.all"
    "svg.context-properties.content.enabled"
  )

  for config in ${configs[@]}; do
    sed -i -e "s/\((\"${config}\", \).*)/\1true)/" $path
  done
}

copy_userchrome() {
  local path=""
  if [[ -d ~/.mozilla ]]; then
    path="$(find ~/.mozilla/firefox -name *.default-release -type d)"
  else
    path="$(find ~/snap/firefox/common/.mozilla/firefox -name *.default -type d)"
  fi

  if [[ ! -d $path/chrome ]]; then
      mkdir -p $path/chrome
  fi

  ln -s "$RESOURCE/userChrome.css" "$path/chrome"
}

change_config
copy_userchrome
