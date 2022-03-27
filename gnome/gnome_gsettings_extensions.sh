#!/usr/bin/env bash

GNOME_EXTENSIONS_SETTINGS="./gnome/settings.json"

set -eo pipefail

schemadir() {
  local name="$1"
  local prefix="$XDG_DATA_HOME/gnome-shell/extensions"
  local output="$(compgen -G $prefix/${name}*)"
  echo "$output/schemas"
}

set_gsettings_extensions() {
  local extensions=()
  readarray -t extensions < <(jq -r 'keys' $GNOME_EXTENSIONS_SETTINGS | tr -d '[]," ')

  for name in ${extensions[@]}; do
    local schema="$(schemadir $name)"
    if [[ ! -d "$schema" ]]; then
      if ! gsettings list-recursively org.gnom.shell.extensions.$name; then
        echo "Skipping '$name'. (Directory does not exist)"
        continue
      fi
    fi

    local items=($(jq -r '.["'"$name"'"] | to_entries | map("\(.key)=\(.value|tostring)")|.[]' $GNOME_EXTENSIONS_SETTINGS | tr -d '{}'))
    for item in ${items[@]}; do
      local key=${item%=*}
      local value=$(tr '"' "'" <<<${item#*=})

      gsettings --schemadir $schema set org.gnome.shell.extensions.$name $key $value
    done
  done
}

set_gsettings_extensions
