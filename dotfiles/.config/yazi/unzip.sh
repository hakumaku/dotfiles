#!/usr/bin/env bash

function unzip_each() {
  local files
  readarray -t files < <(find "$1" -maxdepth 1 -type f -name "*.zip")
  echo "${files[@]}"
  for file in "${files[@]}"; do
    unzip -q "$file" -d "${file%.*}"
  done
}

unzip_each .
