return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- https://github.com/folke/todo-comments.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
  },
  keys = {
    { "<leader>td", "<cmd>TodoTelescope<cr>" },
    { "<leader>tt", "<cmd>TodoTrouble<cr>" },
  },
}
