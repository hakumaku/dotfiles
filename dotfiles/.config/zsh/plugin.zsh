# zsh-vi-mode
function load_plugins() {
  local dir="$XDG_DATA_HOME/repositories"
  local plugins=(
    "powerlevel10k/powerlevel10k.zsh-theme romkatv/powerlevel10k"
    "zsh-autosuggestions/zsh-autosuggestions.zsh zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh zsh-users/zsh-syntax-highlighting"
    "fzf-tab/fzf-tab.plugin.zsh Aloxaf/fzf-tab"
    "zsh-vi-mode/zsh-vi-mode.plugin.zsh jeffreytse/zsh-vi-mode"
  )
  for plugin in "${plugins[@]}"; do
    set -- $plugin # Convert the "tuple" into the param args $1 $2...
    if [[ ! -f "$dir/$1" ]]; then
      git clone --depth=1 "git@github.com:${2}.git"
    fi
    source "$dir/$1"
  done
  # powerlevel10k: to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  if [[ -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]]; then
    source $XDG_CONFIG_HOME/zsh/.p10k.zsh
  fi
}

function _zsh_vi_mode_init() {
  # fzf
  if [[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ]]; then
    source $XDG_CONFIG_HOME/fzf/fzf.zsh
    # FZF (https://github.com/junegunn/fzf)
    # Use ~~ as the trigger sequence instead of the default **
    export FZF_COMPLETION_TRIGGER='~~'
    # Options to fzf command
    export FZF_COMPLETION_OPTS='+c -x'
    # Setting fd as the default source for fzf
    export FZF_DEFAULT_COMMAND='fd --type f'
    # To apply the command to CTRL-T as well
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    # CTRL-/ to toggle small preview window to see the full command
    # CTRL-Y to copy the command into clipboard using pbcopy
    export FZF_CTRL_R_OPTS="\
        --preview 'echo {}' \
        --preview-window up:3:hidden:wrap \
        --layout=reverse \
        --bind 'ctrl-/:toggle-preview' \
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
        --color header:italic \
        --header 'Press CTRL-Y to copy command into clipboard'"
    # zoxide
    export _ZO_FZF_OPTS="$FZF_CTRL_R_OPTS"
  fi

  # Key bindings for zsh-vi-mode
  bindkey -v
  bindkey "^j" history-beginning-search-forward
  bindkey "^k" history-beginning-search-backward
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
  bindkey -M menuselect 'j' vi-down-line-or-history

  bindkey '^y' autosuggest-accept
}

load_plugins
zvm_after_init_commands+=(_zsh_vi_mode_init)
