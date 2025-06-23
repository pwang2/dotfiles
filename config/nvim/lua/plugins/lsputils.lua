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
    config = function()
      -- https://github.com/Chaitanyabsprip/fastaction.nvim?tab=readme-ov-file#configuration
      require("fastaction").setup({
        dismiss_keys = { "j", "k", "<c-c>", "q" },
        keys = "qwertyuiopasdfghlzxcvbnm",
        popup = {
          border = "rounded",
          hide_cursor = true,
          highlight = {
            divider = "FloatBorder",
            key = "MoreMsg",
            title = "Title",
            window = "NormalFloat",
          },
          title = "Select one of:",
        },
        priority = {
          typescript = {
            -- { pattern = "from module", key = "i", order = 1 },
          },
        },
        register_ui_select = false,
      })
    end,
  },
}
