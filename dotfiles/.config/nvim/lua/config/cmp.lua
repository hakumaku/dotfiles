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
    ["<CR>"] = cmp.mapping.confirm({select = true})
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
  experimental = {native_menu = false, ghost_text = true}
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
