#!/usr/bin/env bash

change_config() {
  local path="$(find ~/.mozilla/firefox -name *.default-release -type d)/prefs.js"

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

download_cascade() {
  local path="$(find ~/.mozilla/firefox -name *.default-release -type d)"

  if [[ ! -d $path/chrome ]]; then
      mkdir -p $path/chrome
  fi

  curl -L https://raw.githubusercontent.com/andreasgrafen/cascade/main/userChrome.css \
      -o $path/chrome/userChrome.css
}

change_config
download_cascade
