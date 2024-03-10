#!/usr/bin/env bash

function unzip_each_here() {
  local files
  readarray -t files < <(find "$1" -maxdepth 1 -type f -name "*.zip")
  echo "${files[@]}"
  local here=$(pwd)
  for file in "${files[@]}"; do
    unzip -q "$file" -d "$here"
  done
}

unzip_each_here .
