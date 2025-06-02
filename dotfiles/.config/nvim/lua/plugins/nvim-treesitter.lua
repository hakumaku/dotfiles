return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
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
        "markdown_inline",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
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
          "devicetree",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      multiwindow = false, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },
}
