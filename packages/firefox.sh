#!/usr/bin/env bash

change_config() {
  # TODO: intially lines are empty
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

copy_userchrome() {
  local path="$(find ~/.mozilla/firefox -name *.default-release -type d)"

  if [[ ! -d $path/chrome ]]; then
      mkdir -p $path/chrome
  fi

  ln -s "$RESOURCE/userChrome.css" "$path/chrome"
}

change_config
copy_userchrome
