---@class LazySpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- https://github.com/folke/which-key.nvim
  ---@class wk.Opts
  opts = {
    preset = "helix",
    delay = 500,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<leader>??",
      function()
        require("which-key").show()
      end,
      desc = "All Keymaps (which-key)",
    },
  },
}
