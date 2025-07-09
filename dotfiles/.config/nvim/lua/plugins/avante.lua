return {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "gemini",
    mode = "legacy", -- "agentic"
    auto_suggestions_provider = nil,
    providers = {
      gemini = {
        -- @see https://ai.google.dev/gemini-api/docs/models/gemini
        model = "gemini-2.5-flash",
        timeout = 30000, -- Timeout in milliseconds
        -- context_window = 1048576,
        -- use_ReAct_prompt = true,
        -- extra_request_body = {
        --   generationConfig = {
        --     temperature = 0.75,
        --   },
        -- },
      },
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false, -- Experimental stage
      auto_suggestions_respect_ignore = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      use_cwd_as_project_root = false,
      auto_focus_on_diff_view = false,
      ---@type boolean | string[] -- true: auto-approve all tools, false: normal prompts, string[]: auto-approve specific tools by name
      auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
      auto_check_diagnostics = true,
    },
    selector = {
      provider = "snacks",
      provider_opts = {},
      exclude_auto_select = {}, -- List of items to exclude from auto selection
    },
    hints = { enabled = false },
    windows = {
      position = "right",
      wrap = true,
      width = 50,
      sidebar_header = {
        enabled = false, -- true, false to enable/disable the header
        align = "left", -- left, center, right for title
        rounded = false,
      },
      input = {
        prefix = "> ",
        height = 12,
      },
      edit = {
        border = "rounded",
        start_insert = false, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
