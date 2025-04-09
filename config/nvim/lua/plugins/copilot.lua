return {
  {
    "github/copilot.vim",
    enabled = true,
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>c",
        "<cmd>CodeCompanionChat toggle<cr>",
        desc = "toggle chat window",
      },
      {
        "<leader>a",
        "<cmd>CodeCompanionAction<cr>",
        desc = "toggle codecompanion action window",
        noremap = true,
      },
    },
  },
}
