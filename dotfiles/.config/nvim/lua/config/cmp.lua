local lspkind = require('lspkind')
local cmp = require('cmp')

local select_next_item = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local select_prev_item = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

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
    ["<Tab>"] = select_next_item,
    ["<S-Tab>"] = select_prev_item,
    ["<C-n>"] = select_next_item,
    ["<C-p>"] = select_prev_item
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
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

-- "CmpItemAbbr"
-- "CmpItemAbbrDeprecated"
-- "CmpItemAbbrMatch"
-- "CmpItemAbbrMatchFuzzy"
-- "CmpItemKind"
-- "CmpItemMenu"
