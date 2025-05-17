return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "'",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
    },
    {
      "mm",
      function()
        require("harpoon.mark").add_file()
      end,
    },
  },
}
