return {
  -- Look & Feel
  {'kyazdani42/nvim-web-devicons', lazy = true},
  'folke/todo-comments.nvim',
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = {
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false, -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules
        colorblind = {
          enable = false, -- Enable colorblind support
          simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          severity = {
            protan = 0, -- Severity [0,1] for protan (red)
            deutan = 0, -- Severity [0,1] for deutan (green)
            tritan = 0 -- Severity [0,1] for tritan (blue)
          }
        },
        styles = { -- Style to be applied to different syntax groups
          comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "NONE",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "NONE",
          variables = "NONE"
        },
        inverse = { -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false
        },
        modules = { -- List of various plugins and additional options
          -- ...
        }
      },
      palettes = {},
      specs = {},
      groups = {}
    }
  },
  {
    'mhinz/vim-startify',
    config = function()
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
        {y = "~/.config/yazi/yazi.toml"},
        {f = "~/.config/foot/foot.ini"}
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
    end
  }
}
