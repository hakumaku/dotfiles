vim.g.startify_bookmarks = {
  {z = "~/.zshrc"},
  {g = "~/.gitconfig"},
  {n = "~/.config/nvim/init.lua"},
  {t = "~/.tmux.conf"},
  {a = "~/.config/alacritty/alacritty.yml"},
  {w = "~/workspace/test"},
  {u = "~/.packages/ubuntu-fresh/ubuntu/main.sh"},
  {m = "~/.config/awesome/rc.lua"},
  {c = "~/.config/compton/compton.conf"}
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