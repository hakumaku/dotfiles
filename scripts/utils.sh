#!/usr/bin/env bash

wm() {
  xprop | awk '
		/^WM_CLASS/{sub(/.* =/, "instance:"); sub(/,/, "\nclass:"); print}
		/^WM_NAME/{sub(/.* =/, "title:"); print}'
}

enable_perf() {
  sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
  sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
}

gf() {
  # %h: abbreviated commit hash
  # %ar: author date, relative
  # %d: ref names
  # %s: subject
  # %+b: a line-feed and body
  # %ae: author email
  # %an: author name
  local _delta="delta --side-by-side --width ${FZF_PREVIEW_COLUMNS:-$COLUMNS}"
  local _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
  local _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | delta'"
  local _viewGitLogLineFocused="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | $_delta'"

  git log \
    --graph \
    --decorate \
    --color=always \
    --format="%C(cyan)%h %C(auto)%d %C(yellow)%s%+b %C(auto)%an" "$@" \
    | fzf --no-sort \
      --reverse \
      --tiebreak=index \
      --no-multi \
      --ansi \
      --preview="$_viewGitLogLine" \
      --header "enter: view, C-c:copy hash" \
      --bind "enter:execute:$_viewGitLogLineFocused | less -R" \
      --bind "ctrl-c:execute:$_gitLogLineToHash | xclip -r -selection clipboard"
}
