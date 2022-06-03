local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup {
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
    ["<C-n>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<C-p>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end
  },
  sources = {
    {name = "ultisnips"},
    {name = "nvim_lua"},
    {name = "nvim_lsp"},
    {name = "path"},
    {name = "luasnip"},
    {name = "buffer", keyword_length = 5}
  },
  formatting = {format = lspkind.cmp_format()},
  -- view = {entries = 'native'},
  experimental = {ghost_text = true}
}
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

-- "CmpItemAbbr"
-- "CmpItemAbbrDeprecated"
-- "CmpItemAbbrMatch"
-- "CmpItemAbbrMatchFuzzy"
-- "CmpItemKind"
-- "CmpItemMenu"
