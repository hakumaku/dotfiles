function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=($(COMP_WORDS="$words[*]" \
    COMP_CWORD=$((cword - 1)) \
    PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null))
}
compctl -K _pip_completion /usr/bin/python3 -m pip
compctl -K _pip_completion pip3

# aws completion
if command -v aws &>/dev/null; then
  complete -C "$(which aws_completer)" aws
fi

# terraform completion
if command -v terraform &>/dev/null; then
  complete -o nospace -C "$(which terraform)" terraform
fi

# packer completion
if command -v packer &>/dev/null; then
  complete -o nospace -C "$(which packer)" packer
fi

