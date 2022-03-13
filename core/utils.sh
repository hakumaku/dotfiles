#!/usr/bin/env bash

export PKGINFO="$XDG_DATA_HOME/dotfiles/packages/data.json"

msg() {
  local type="$1"
  local msg="$2"
  case $type in
    title)
      printf "\e[1;36m%10s: %s\e[0m\n" "[target]" "${msg}"
      ;;
    progress)
      printf "\e[1;34m%10s: %s\e[0m\n" "[progress]" "${msg}"
      ;;
    info)
      printf "\e[1;32m%10s: %s\e[0m\n" "[info]" "${msg}"
      ;;
    warning)
      printf "\e[1;33m%10s: %s\e[0m\n" "[warning]" "${msg}"
      ;;
    error)
      printf "\e[1;31m%10s: %s\e[0m\n" "[error]" "${msg}"
      ;;
    *)
      echo "invalid type in msg()"
      exit 1
      ;;
  esac
}

read_dependencies() {
  local -n _deps=$1
  local name="$2"
  local distro="$3"
  readarray -t _deps < <(jq -r ".${name}.${distro}.dependencies" $PKGINFO | tr -d '[]," ')
}

install_dependencies() {
  local pkg="$1"

  msg info "installing dependencies"

  local -a deps
  case $DISTRO in
    "ubuntu")
      read_dependencies deps ${pkg} "ubuntu"
      if [[ ${#deps[@]} -gt 0 ]]; then
        sudo apt -qq install ${deps[@]}
      fi
      ;;
    "arch")
      read_dependencies deps ${pkg} "arch"
      if [[ ${#deps[@]} -gt 0 ]]; then
        sudo pacman -Syq --needed ${deps[@]}
      fi
      ;;
    *)
      msg error "unrecognized DISTRO: '$DISTRO'"
      ;;
  esac
}

read_packages() {
  local -n _packages=$1
  local name="$2"
  local distro="$3"
  readarray -t _packages < <(jq -r ".${name}.${distro}.packages" $PKGINFO | tr -d '[]," ')
}

install_package() {
  local pkg="$1"

  msg info "installing packages"

  local -a packages
  case $DISTRO in
    "ubuntu")
      read_packages packages ${pkg} "ubuntu"
      if [[ ${#packages[@]} -gt 0 ]]; then
        sudo apt -qq install ${packages[@]}
      fi
      ;;
    "arch")
      read_packages packages ${pkg} "arch"
      if [[ ${#packages[@]} -gt 0 ]]; then
        sudo pacman -Syq ${packages[@]}
      fi
      ;;
    *)
      msg error "unrecognized DISTRO: '$DISTRO'"
      ;;
  esac
}

# $1: url
#   e.g, "davatorium/rofi"
# $2: expression to grep file
#   e.g, "rofi-.*\.tar\.gz"
# $3: destination
# $4: local version
fetch_from_git() {
  local url="https://github.com/$1"
  local repository="${url##*/}"
  repository="${repository/.git/}"
  local expr="$2"
  local dest="$3"
  local local_version="${4:-}"

  local link="$url/releases/$(curl -Ls "$url/releases/latest" | grep -wo "download/[v]\?.*/$expr")"
  if [[ ! -z $local_version ]]; then
    local remote_version=$(echo $link | sed -rn 's/.*\/v?(.*)\/.*/\1/p')

    if [[ $local_version = $remote_version ]] \
      || [[ $local_version = "v$remote_version" ]]; then
      msg info "$repository - already up to date ($remote_version)"
      return
    else
      msg info "$repository - upgrading to $remote_version from $local_version"
    fi
  fi

  local artifact=${link##*/}
  msg progress "downloading '$link'"
  curl --silent --location --output "$dest/$artifact" "$link"
  msg progress "$dest/$artifact"
}

# $1: url
#   e.g, "davatorium/rofi"
# $2: destination, if empty string is passed, default path is used.
# $3: submodule ('true' || 'false')
do_clone_or_pull() {
  local url="$1"
  local repository="${url##*/}"
  repository="${repository/.git/}"

  local dest=${2:-"$PREFIX/$repository"}
  local submodule="${3:-}"
  local args=""

  if [[ -z $dest ]]; then
    msg warning "directory does not exist"
    msg warning "$dest"
    mkdir -p $(dirname $dest)
  fi

  if [[ $submodule = "true" ]]; then
    args="--recurse-submodules"
  fi

  if [ ! -d "$dest" ]; then
    msg progress "cloning '$repository'"
    git clone --quiet $args "$url" "$dest"
  else
    msg progress "pulling '$repository'"
    git -C "$dest" pull --quiet $args
  fi

  # msg progress "entering directory '$dest'"
  pushd "$dest" >/dev/null
}

clone_or_pull_aur() {
  local url="https://aur.archlinux.org/$1"
  shift
  do_clone_or_pull $url "$@"
}

clone_or_pull() {
  local url="https://github.com/$1"
  shift
  do_clone_or_pull $url "$@"
}

clone_or_pull_done() {
  # msg progress "leaving directory '$PWD'"
  popd >/dev/null
}

checkout_latest() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local latest=$(git describe --tags $(git rev-list --tags --max-count=1))
    git --config advice.detachedHead=false checkout $latest
  else
    msg error "not a git repository"
  fi
}

assert_config() {
  if [[ -d $HOME/.config/tmux ]]; then
    return
  fi

  install_dependencies init

  # Move config files to XDG_CONFIG_HOME.
  pushd $SCRIPT_HOME
  if [[ -f $HOME/.profile ]]; then
    mv $HOME/.profile $HOME/.profile.orig
  fi
  if [[ -f $HOME/.pam_environment ]]; then
    mv $HOME/.pam_environment $HOME/.pam_environment.orig
  fi
  stow --target=$HOME dotfiles
  popd
}

export -f msg
export -f fetch_from_git
export -f do_clone_or_pull
export -f clone_or_pull_aur
export -f clone_or_pull
export -f clone_or_pull_done
export -f checkout_latest
export -f read_dependencies
export -f read_packages
export -f install_dependencies
export -f install_package
