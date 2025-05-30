return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'kyazdani42/nvim-web-devicons'},
  config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine = require('lualine')

    -- Color table for highlights
    -- stylua: ignore
    local colors = {
      bg = '#202328',
      fg = '#ABB2BF',
      yellow = '#ECBE7B',
      cyan = '#56B6C2',
      darkblue = '#081633',
      green = '#98C379',
      orange = '#D19A66',
      violet = '#a9a1e1',
      magenta = '#C678DD',
      blue = '#61AFEF',
      red = '#E06C75'
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = {c = {fg = colors.fg, bg = colors.bg}},
          inactive = {c = {fg = colors.fg, bg = colors.bg}}
        },
        globalstatus = true
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {"aerial"}
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
      }
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return '▊'
      end,
      color = {fg = colors.blue}, -- Sets highlighting of component
      padding = {left = 0, right = 1} -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        -- auto change color according to neovims mode
        local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          V = 'VISUAL',
          [''] = 'VISUAL',
          v = 'VISUAL',
          ['r?'] = ':CONFIRM',
          rm = '--MORE',
          R = 'REPLACE',
          Rv = 'VIRTUAL',
          s = 'SELECT',
          S = 'SELECT',
          ['r'] = 'HIT-ENTER',
          [''] = 'SELECT',
          t = 'TERMINAL',
          ['!'] = 'SHELL'
        }
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red
        }
        vim.api.nvim_command('hi! LualineMode guifg=' ..
                                 mode_color[vim.fn.mode()] .. ' guibg=' ..
                                 colors.bg)
        return alias[vim.fn.mode()] .. ' '
      end,
      color = 'LualineMode',
      padding = {right = 1}
    }

    ins_left {'branch', icon = '', color = {fg = colors.blue, gui = 'bold'}}

    ins_left {
      'diff',
      symbols = {added = ' ', modified = '󰝤 ', removed = ' '},
      diff_color = {
        added = {fg = colors.green},
        modified = {fg = colors.orange},
        removed = {fg = colors.red}
      },
      cond = conditions.hide_in_width
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = {fg = colors.fg, gui = 'bold'}
    }

    ins_left {
      'diagnostics',
      sources = {'nvim_diagnostic'},
      symbols = {error = ' ', warn = ' ', info = ' '},
      diagnostics_color = {
        color_error = {fg = colors.red},
        color_warn = {fg = colors.yellow},
        color_info = {fg = colors.cyan}
      }
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end
    }

    -- Add components to right sections
    ins_right {
      function()
        return "chars: " .. tostring(vim.fn.wordcount().visual_chars)
      end,
      cond = function()
        local mode = vim.fn.mode()
        return mode == 'v' or mode == '' or mode == 'V'
      end,
      color = {fg = colors.blue}
    }

    ins_right {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = '',
      color = {fg = colors.magenta, gui = 'bold'}
    }

    ins_right {'location'}

    ins_right {'progress', color = {fg = colors.fg, gui = 'bold'}}

    ins_right {'filesize', cond = conditions.buffer_not_empty}

    ins_right {
      'o:encoding', -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = {fg = colors.green, gui = 'bold'}
    }

    ins_right {
      function()
        return '▊'
      end,
      color = {fg = colors.blue},
      padding = {left = 1}
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end
}
