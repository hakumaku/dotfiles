#!/usr/bin/env bash

search_app() {
  declare -n result=$1
  local default_path="/usr/share/applications"
  local snap_path="/var/lib/snapd/desktop/applications"
  local local_path="$HOME/.local/share/applications"

  while [ $# -gt 0 ]; do
    local app=$1
    if [ -f "${snap_path}/${app}_${app}.desktop" ]; then
      application="${snap_path}/${app}_${app}.desktop"
    elif [ -f "${default_path}/${app}.desktop" ]; then
      application="${default_path}/${app}.desktop"
    elif [ -f "${local_path}/${app}.desktop" ]; then
      application="${local_path}/${app}.desktop"
    fi
    if [ ! -z "$application" ]; then
      return
    fi
    shift
  done
}

change_icons() {
  while [ $# -gt 0 ]; do
    local application=""
    local input=$1
    local icon=""

    case "$input" in
      "lol" | "leagueoflegends")
        icon="leagueoflegends"
        search_app application "leagueoflegends"
        ;;
      "discord")
        icon="discord"
        search_app application "discord"
        ;;
      "system" | "gnome-system-monitor")
        icon="system"
        search_app application "gnome-system-monitor"
        ;;
      "code" | "vscode")
        icon="visual-studio-code"
        search_app application "code"
        ;;
      "mailspring")
        icon="mailspring"
        search_app application "mailspring"
        ;;
      "todoist")
        icon="com.todoist.Todoist"
        search_app application "todoist"
        ;;
      "discord")
        icon="discord"
        search_app application "discord"
        ;;
      "spotify")
        icon="spotify"
        search_app application "spotify"
        ;;
      "zenkit")
        icon="zenkit"
        search_app application "zenkit"
        ;;
      "alacritty")
        icon="alacritty"
        search_app application "com.alacritty.Alacritty" \
          "Alacritty"
        ;;
      "slack")
        icon="slack"
        search_app application "slack"
        ;;
      "atom")
        icon="atom"
        search_app application "atom"
        ;;
      "nvidia")
        icon="nvidia-settings"
        search_app application "nvidia-settings"
        ;;
      "obsidian")
        icon="obsidian"
        search_app application "obsidian"
        ;;
      "gimp")
        icon="gimp"
        search_app application "gimp"
        ;;
      "gitkraken" | "kraken")
        icon="gitkraken"
        search_app application "gitkraken"
        ;;
      "thunderbird")
        icon="thunderbird"
        search_app application "thunderbird"
        if [ ! -z $application ]; then
          sudo sed -ri '/(StartupNotify=.*)/a StartupWMClass=Thunderbird' "$application"
          shift
          continue
        fi
        ;;
      "brave")
        icon="brave-browser"
        search_app application "brave-browser"
        if [ ! -z $application ]; then
          sudo sed -ri '/(StartupNotify=.*)/a StartupWMClass=brave-browser' "$application"
          shift
          continue
        fi
        ;;
        # Jetbrains applications
      "pycharm")
        icon="$input"
        search_app application "${input}-community" \
          "${input}-professional" \
          "jetbrains-${input}" \
          "jetbrains-${input}-community" \
          "jetbrains-${input}-professional"
        ;;
      "toolbox")
        icon="jetbrains-$input"
        search_app application "$input" "jetbrains-$input"
        ;;
      "clion" | "datagrip" | "webstorm")
        icon="$input"
        search_app application "$input" "jetbrains-$input"
        ;;
    esac

    if [ ! -z "$application" ]; then
      sudo sed -ri 's/(Icon=)(.*)/\1'${icon}'/' "${application}"
    else
      echo "Cannot find such application: ${input}"
    fi

    shift
  done
}

change_icons "$@"
