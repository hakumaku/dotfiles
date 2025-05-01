return {
  "kiyoon/Korean-IME.nvim",
  keys = {
    -- lazy load on 한영전환
    {
      "<leader>n",
      function()
        require("korean_ime").change_mode()
      end,
      mode = {"i", "n", "x", "s"},
      desc = "한/영"
    }
  }
}
