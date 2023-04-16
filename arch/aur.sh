#!/usr/bin/env bash

export AUR_PKGINFO="./arch/aur.json"

install_aur_packages() {
  local packages=()
  readarray -t packages < <(jq -r 'keys' $AUR_PKGINFO | tr -d '[]," ')

  for pkg in ${packages[@]}; do
    msg info "installing $pkg"
    local url=$(jq -r '.["'"${pkg}"'"].url' $AUR_PKGINFO)
    clone_or_pull_aur $url
    makepkg --syncdeps --install --log --noprogressbar --noconfirm
    clone_or_pull_done
  done

  if [[ -f "/usr/share/applications/spotify.desktop" ]]; then
    local resolution=$(xrandr | grep ' connected primary' | awk '{ print $4 }')
    resolution=${resolution%%x*}
    if [[ $(($resolution - 1980)) -gt 0 ]]; then
      sudo sed -i -r \
        's/(Exec=spotify) .*/\1 --force-device-scale-factor=1.5 %U/' \
        "/usr/share/applications/spotify.desktop"
    fi
  fi
}

install_aur_packages
