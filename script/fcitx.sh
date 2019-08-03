sed -nE "/TriggerKey=(.*)/ { s/\1/asdf/p }" "$HOME/.config/fcitx/config"
