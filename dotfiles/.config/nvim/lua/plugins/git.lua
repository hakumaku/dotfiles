return {
  -- Git Integration
  {'lewis6991/gitsigns.nvim', opts = {}},
  {
    "NeogitOrg/neogit",
    dependencies = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
    opts = {
      -- Hides the hints at the top of the status buffer
      disable_hint = true,
      -- "ascii"   is the graph the git CLI generates
      -- "unicode" is the graph like https://github.com/rbong/vim-flog
      graph_style = "unicode",
      -- Change the default way of opening neogit
      kind = "vsplit",
      log_view = {kind = "vsplit"},
      reflog_view = {kind = "vsplit"}
    }
  }
}
