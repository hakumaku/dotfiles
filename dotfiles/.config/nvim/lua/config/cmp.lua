local lspkind = require('lspkind')
local cmp = require('cmp')
local types = require('cmp.types')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local fields = {
  [types.lsp.CompletionItemKind.EnumMember] = 100,
  [types.lsp.CompletionItemKind.Property] = 90,
  [types.lsp.CompletionItemKind.Variable] = 80,
  [types.lsp.CompletionItemKind.Field] = 70
}

local select_next_item = function(fallback)
  if cmp.visible() then
    cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
  else
    fallback()
  end
end

local select_prev_item = function(fallback)
  if cmp.visible() then
    cmp_ultisnips_mappings.jump_backwards(fallback)
  else
    fallback()
  end
end

cmp.setup {
  enabled = function()
    return vim.api.nvim_get_option_value("buftype", {}) ~= "prompt" or
               require("cmp_dap").is_dap_buffer()
  end,
  completion = {completeopt = 'menu,menuone,noinsert'},
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    },
    ["<C-space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ["<C-n>"] = cmp.mapping(select_next_item, {"i", "s", "c"}),
    ["<C-p>"] = cmp.mapping(select_prev_item, {"i", "s", "c"})
  },
  sources = {
    {name = "nvim_lsp", priority = 10},
    {name = "buffer", priority = 9, keyword_length = 5},
    {name = "ultisnips", priority = 6},
    {name = "path", priority = 4},
    {name = "nvim_lua", priority = 3}
  },
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#menu-type
  window = {
    completion = {
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0
    }
  },
  formatting = {
    fields = {"kind", "abbr", "menu"},
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({mode = "symbol_text", maxwidth = 50})(
                       entry, vim_item)
      local strings = vim.split(kind.kind, "%s", {trimempty = true})
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
    expandable_indicator = false
  },
  -- view = {entries = 'native'},
  experimental = {ghost_text = true},
  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,
      -- cmp.config.compare.kind,
      function(entry1, entry2)
        local kind1 = fields[entry1:get_kind()] or 0
        local kind2 = fields[entry2:get_kind()] or 0
        if kind1 > kind2 then
          return true
        elseif kind1 < kind2 then
          return false
        end
      end,
      cmp.config.compare.length,
      cmp.config.compare.order
    }
  }
}

-- database
cmp.setup.filetype(
  {"sql"},
  {
    sources = {
      { name = "vim-dadbod-completion" },
      { name = "buffer" },
    }
  }
)

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", {clear = true}),
  pattern = "Cargo.toml",
  callback = function()
    cmp.setup.buffer({sources = {{name = "crates"}}})
  end
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

cmp.setup.filetype({"dap-repl", "dapui_watches", "dapui_hover"},
                   {sources = {{name = "dap"}}})

-- "CmpItemAbbr"
-- "CmpItemAbbrDeprecated"
-- "CmpItemAbbrMatch"
-- "CmpItemAbbrMatchFuzzy"
-- "CmpItemKind"
-- "CmpItemMenu"
