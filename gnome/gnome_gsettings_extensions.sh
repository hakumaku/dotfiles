#!/usr/bin/env bash

GNOME_EXTENSIONS_SETTINGS="./gnome/settings.json"

set -eo pipefail

schemadir() {
  local name="$1"
  local prefix="$XDG_DATA_HOME/gnome-shell/extensions"
  local output="$(compgen -G $prefix/$name*)"
  echo "$output/schemas"
}

set_gsettings_extensions() {
  local name="$1"
  local schema="--schemadir $(schemadir $name)"
  local extensions=()
  if [[ ! -d $schema ]]; then
    echo "Skipping '$name'. (Directory does not exist)"
  fi

  readarray -t extensions < <(jq -r 'keys' $GNOME_EXTENSIONS_SETTINGS | tr -d '[]," ')

  for name in ${extensions[@]}; do
    local items=($(jq -r '.["'"$name"'"] | to_entries | map("\(.key)=\(.value|tostring)")|.[]' $GNOME_EXTENSIONS_SETTINGS | tr -d '{}'))
    for item in ${items[@]}; do
      local key=${item%=*}
      local value=${item#*=}
      gsettings $schema set org.gnome.shell.extensions.$name $key $value
    done
  done
}

set_gsettings_extensions dash-to-dock
set_gsettings_extensions gtktitlebar
