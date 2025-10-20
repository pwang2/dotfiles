return {
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    config = function()
      -- https://github.com/kosayoda/nvim-lightbulb?tab=readme-ov-file#configuration
      require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
      })
    end,
  },
  {
    "Chaitanyabsprip/fastaction.nvim",
    event = "LspAttach",
    -- https://github.com/Chaitanyabsprip/fastaction.nvim?tab=readme-ov-file#configuration
    ---@type FastActionConfig
    opts = {
      dismiss_keys = { "j", "k", "<c-c>", "q" },
      keys = "qwertyuiopasdfghlzxcvbnm",
      priority = {
        typescript = {
          { pattern = "Add import from", key = "a", order = 1 },
        },
      },
    },
  },
}
