local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local lambda = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

local termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- local check_back_space = function()
--   local col = vim.fn.col('.') - 1
--   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--     return true
--   else
--     return false
--   end
-- end

_G.lua_snip_jump_next = function()
  if ls.jumpable(1) then
    return termcodes("<Plug>luasnip-jump-next")
  end

  return termcodes("<C-j>")
end

_G.lua_snip_jump_prev = function()
  if ls.jumpable(-1) then
    return termcodes("<Plug>luasnip-jump-prev")
  end

  return termcodes("<C-k>")
end

ls.snippets = {
  all = {
    s("fmt1", fmt("To {title} {} {}.", {
      i(2, "Name"),
      i(3, "Surname"),
      title = c(1, {t("Mr."), t("Ms.")})
    })),
    s("ternary", {
      -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
      i(1, "cond"),
      t(" ? "),
      i(2, "then"),
      t(" : "),
      i(3, "else")
    })
  }
}
