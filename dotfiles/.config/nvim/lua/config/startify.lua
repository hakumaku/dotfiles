vim.g.startify_bookmarks = {
  {z = "~/.config/zsh/.zshrc"},
  {g = "~/.config/git/config"},
  {n = "~/.config/nvim/init.lua"},
  {t = "~/.config/tmux/tmux.conf"},
  {a = "~/.config/alacritty/alacritty.toml"},
  {k = "~/.config/kitty/kitty.conf"},
  {d = "~/.config/dunst/dunstrc"},
  {w = "~/.config/waybar/config"},
  {h = "~/.config/hypr/hyprland.conf"},
}
vim.g.startify_lists = {
  {header = {'  Bookmarks'}, type = 'bookmarks'},
  {header = {'  Most Recently Used'}, type = 'dir'}
  -- {header = {'  Commits'}, type = list_commits}
}

vim.g.startify_use_unicode = true
vim.g.startify_change_to_vcs_root = true
vim.g.startify_change_to_dir = true
vim.g.startify_enable_special = true
vim.g.startify_padding_left = 8
