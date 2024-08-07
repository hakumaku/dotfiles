# fg-bg toggle via c-z
function _fg_bg {
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}

function webp {
  mogrify -format jpg *.webp \
    && rm -rf *.webp
}

function unzip_each() {
  # zsh equivalent of bash
  # readarray -t files < <(find "$1" -maxdepth 1 -type f -name "*.zip")
  local files=("${(@f)$(find "$1" -maxdepth 1 -type f -name "*.zip")}")
  echo "${files[@]}"
  for file in "${files[@]}"; do
    unzip -q "$file" -d "${file%.*}"
  done
}
alias untar="unzip_each ."

function compress {
  mogrify -compress JPEG -quality 70 *.jpg
}

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
function _fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
function _fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

function _fzf_commit() {
  local filter
  if [ -n $@ ] && [ -e $@ ]; then
    filter="-- $@"
  fi
  export LESS='-R'
  export BAT_PAGER='less -S -R -M -i'
  git log \
    --graph --color=always --abbrev=7 \
    --format=format:"%C(bold blue)%h%C(reset) %C(dim white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset) %C(bold green)(%ar)%C(reset)" $@ \
    | fzf --ansi --no-sort --layout=reverse --tiebreak=index \
      --preview="f() { set -- \$(echo -- \$@ | rg -o '\\b[a-f0-9]{7,}\\b'); [ \$# -eq 0 ] || git show --color=always \$1 \$filter | delta --line-numbers; }; f {}" \
      --preview-window=right:50%
}

function _fzf_commit_wo_view() {
  local filter
  if [ -n $@ ] && [ -e $@ ]; then
    filter="-- $@"
  fi
  export LESS='-R'
  export BAT_PAGER='less -S -R -M -i'
  git log \
    --graph --color=always --abbrev=7 \
    --format=format:"%C(bold blue)%h%C(reset) %C(dim white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset) %C(bold green)(%ar)%C(reset)" $@ \
    | fzf --ansi --no-sort --layout=reverse --tiebreak=index
}

