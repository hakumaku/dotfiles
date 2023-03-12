#!/usr/bin/env bash

set -euo pipefail

repo="luals/lua-language-server"
expr="lua-language-server-.*-linux-x64.tar.gz"

default_dir="$XDG_CACHE_HOME/nvim/lspconfig/lua-language-server"
bin="$default_dir/bin/lua-language-server"
install_path="${HOME}/.local/bin/lua-language-server"

fetch_from_git_lua_language_server() {
  if [[ ! -d $default_dir ]]; then
    mkdir -p $default_dir
  fi

  if command -v $bin &>/dev/null; then
    local local_version=$($bin --version)
    fetch_from_git "$repo" "$expr" $default_dir $local_version
  else
    fetch_from_git "$repo" "$expr" $default_dir
  fi

  local output="$(compgen -G $default_dir/lua-language-server-*)"
  if [[ -f $output ]]; then
    msg info "extracting binary"
    tar -xzf $output --overwrite --directory $default_dir
    rm $output
  fi

  if [[ ! -f $install_path ]]; then
    msg info "creating binary script to execute lua-language-server"
    cp "${SCRIPT_HOME}/scripts/lua-language-server" $install_path
    chmod +x $install_path
  fi

  whereis $bin
  $bin --version
}

fetch_from_git_lua_language_server
