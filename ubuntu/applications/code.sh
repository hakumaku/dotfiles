#!/usr/bin/env bash

update_keyvalue() {
  local file="/usr/share/codium/resources/app/product.json"
  local key=$1
  local value=${2//\//\\\/}
  value=${value//:/\\:}

  if [[ ! -f $file ]]; then
    echo "Invalid argument: $file"
    echo "  File does not exist"
    exit 1
  fi

  sudo sed -i -e 's/\(\"'$key'\"\:\) \".*\"/\1 \"'$value'\"/' $file
}

install_codium_impl() {
  sudo apt install codium
  update_keyvalue serviceUrl https://marketplace.visualstudio.com/_apis/public/gallery
  update_keyvalue itemUrl https://marketplace.visualstudio.com/items
}

install_codium() {
  if ! command -v codium &>/dev/null; then
    local vscodium="/etc/apt/sources.list.d/vscodium.list"
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg
    echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append $vscodium
    sudo apt update
    install_codium_impl
    codium --install-extension shan.code-settings-sync
  else
    install_codium_impl
  fi

}

install_codium
