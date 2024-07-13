# Environment variables
export HISTFILE=$HOME/.cache/.zsh_histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LESS="--ignore-case --window=-4 -R"
export PAGER="less"
export EDITOR=nvim
export VISUAL="$EDITOR"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -pl man'"

# Auto completions path
fpath+=${XDG_DATA_HOME}/zsh/site-functions
[[ -d $XDG_DATA_HOME/repositories/zsh-completions ]] && fpath+=$XDG_DATA_HOME/repositories/zsh-completions/src

# Disable pressing <C-s> to freeze.
stty -ixon

# zsh basic settings
# compinit: advanced tab-completion
# promptinit: advanced prompt support
autoload -Uz compinit promptinit
zmodload zsh/complist
autoload bashcompinit
compinit
promptinit
bashcompinit
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Tmux
if command -v tmux &>/dev/null \
  && [ -n "$PS1" ] \
  && [[ ! "$TERM" =~ screen ]] \
  && [[ ! "$TERM" =~ tmux ]] \
  && [ -z "$TMUX" ]; then
  # && [[ ! "$TERM" =~ xterm-kitty ]]; then
  export TERM_PROGRAM=$TERM
  exec tmux
fi

zle -N _fg_bg
bindkey '^z' _fg_bg

alias pubip="curl 'https://api.ipify.org?format=txt'"

bindkey -s '^w9' "cd $XDG_DATA_HOME/dotfiles^M"
bindkey -s '^w0' "cd $XDG_DATA_HOME/repositories^M"

# <C-,> = <C-q>a
# <C-.> = <C-q>b
# <C-/> = <C-q>c
# <C-;> = <C-q>d
bindkey -s '^qa' "^Ulazydocker^M"
bindkey -s '^qb' "^Ulazygit^M"
bindkey -s '^qc' "^Ubtm^M"
bindkey -s '^o' "^Uyazi^M"

# source some files
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/plugins.zsh"

# TODO: cache zoxide output
load_nvm() {
  # nvm (https://github.com/nvm-sh/nvm)
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

load_pyenv() {
  # pyenv (https://github.com/pyenv/pyenv)
  export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
  fi
}

# zoxide (https://github.com/ajeetdsouza/zoxide)
eval "$(zoxide init zsh)"

# foot (https://codeberg.org/dnkl/foot#jumping-between-prompts)
precmd() {
  print -Pn "\e]133;A\e\\"
}
