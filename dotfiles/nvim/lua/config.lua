local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
		['<C-j>'] = actions.move_selection_next,
		['<C-k>'] = actions.move_selection_previous,
      },
    },
  }
}

require('nvim-treesitter.configs').setup {
  ensure_installed = {"c", "cpp", "python", "lua", "comment", "json", "regex", "bash", "html", "css", "yaml", "javascript"},
  highlight = {
    enable = true,
    disable = {"java", "kotlin", "nix", "dart", "rst", "fennel", "erlang", "ocaml",
               "ocaml_interface", "teal", "ocamllex", "clojure", "swift", "r", "c_sharp", "svelte", "tsx", "julia",
               "typescript", "rust", "gdscript", "ledger", "sparql", "query", "verilog", "scala",
               "supercollider", "go", "haskell", "jsdoc", "toml", "glimmer", "ruby", "ql", "elm", "jsonc",
               "vue", "graphql", "turtle", "php", "devicetree"}
  }
}

