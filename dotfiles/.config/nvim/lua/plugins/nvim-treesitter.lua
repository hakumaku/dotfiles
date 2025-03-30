return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = {
      modules = {},
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
      -- List of parsers to ignore installing (or "all")
      ignore_install = {},
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "python",
        "lua",
        "comment",
        "json",
        "regex",
        "hcl",
        "bash",
        "html",
        "css",
        "yaml",
        "javascript",
        "markdown",
        "markdown_inline"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"markdown"},
        disable = {
          "java",
          "kotlin",
          "nix",
          "dart",
          "rst",
          "fennel",
          "erlang",
          "ocaml",
          "ocaml_interface",
          "teal",
          "ocamllex",
          "clojure",
          "swift",
          "r",
          "c_sharp",
          "svelte",
          "tsx",
          "julia",
          "typescript",
          "gdscript",
          "ledger",
          "sparql",
          "query",
          "verilog",
          "scala",
          "supercollider",
          "go",
          "haskell",
          "jsdoc",
          "toml",
          "glimmer",
          "ruby",
          "ql",
          "elm",
          "jsonc",
          "vue",
          "graphql",
          "turtle",
          "php",
          "devicetree"
        }
      }
    }
  }
}
